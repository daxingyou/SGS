require 'xcodeproj'
require 'rubygems'
require 'json'

def getRelativePath (str1, str2)
	# puts("        \033[35m getRelativePath str1: " + str1)
	# puts("        \033[35m getRelativePath str2: " + str2)

   	strPath1 = str1.split("/")
   	if strPath1.length > 0 and strPath1[0].empty?
   		strPath1.shift()
   	end
   	strPath2 = str2.split("/")
   	if strPath2.length > 0 and strPath2[0].empty?
   		strPath2.shift()
   	end

   	index = 0
   	count = [strPath1.length, strPath2.length].min
   	for i in 0..count-1
	   	if strPath1[i] != strPath2[i]
	   		break
	   	end
	   	index = i+1
	end
	ret = ""
	for i in index..strPath2.length-1
		if ret.empty?
			ret = ".."
		else
			ret = File.join(ret, "..")
		end
	end
	for i in index..strPath1.length-1
		ret = File.join(ret, strPath1[i])
	end

	return ret
end

# arg
pathProject 				= ARGV[0]
targetName 					= ARGV[1]
appPackage					= ARGV[2]
appName 					= ARGV[3]
teamID 						= ARGV[4]
provisioningProfileDebug 	= ARGV[5]
provisioningProfileRelease 	= ARGV[6]
entitlements 				= ARGV[7]


# path
pathIosRuntime 		= File.join(pathProject, "frameworks", "runtime-src", "proj.ios_mac")
pathIos 			= File.join(pathProject, "frameworks", "runtime-src", "proj.ios_mac", "ios")
pathXcodeproj 		= File.join(pathProject, "frameworks", "runtime-src", "proj.ios_mac", "xgame.xcodeproj")
pathSdkLib 			= File.join(pathProject, "sdk", "libs")
pathSdkInclude 		= File.join(pathProject, "sdk", "include")
pathSdkRes 			= File.join(pathProject, "sdk", "res")
pathSdkXcassets 	= File.join(pathProject, "sdk", "Images.xcassets")
pathSdkFramework 	= File.join(pathProject, "sdk", "info", "frameworks.json")


#
puts("\033[34mProject Path: " + pathXcodeproj)
puts("    \033[0mRuntimePath:      " + pathIosRuntime)
puts("    \033[0mSdkLibraryPath:   " + pathSdkLib)
puts("    \033[0mSdkResourcesPath: " + pathSdkRes)
puts("    \033[0mSdkXcassetsPath:  " + pathSdkXcassets)

#
frameworkList = JSON.parse(File.read(pathSdkFramework))

# open xcodeproj file
xcodeProject = Xcodeproj::Project.open(pathXcodeproj)

# find target
xcodeTarget = nil
xcodeProject.targets.each do |target|
	if target.name == targetName
		xcodeTarget = target
	end
end



# add files
if xcodeTarget
	puts("\033[34mTarget Name: " + xcodeTarget.name + " Modify------------------------\033[0m")
	# lib
	xcodeTarget.build_configurations.each do |bc|
		puts("    \033[35mBuildSettings Name: " + bc.name)
		headerPath 		= File.join("$(SRCROOT)", getRelativePath(pathSdkInclude, pathIosRuntime))
		frameworkPath 	= File.join("$(SRCROOT)", getRelativePath(pathSdkLib, pathIosRuntime))
		libraryPath 	= File.join("$(SRCROOT)", getRelativePath(pathSdkLib, pathIosRuntime))
		puts("        \033[0mHeaderPath: " + headerPath)
		puts("        \033[0mFrameworkPath: " + frameworkPath)
		puts("        \033[0mLibraryPath: " + libraryPath)
		
		# header paths
		headerSearchPaths = bc.build_settings["HEADER_SEARCH_PATHS"]
		if headerSearchPaths.class == Array
			headerSearchPaths.push(headerPath)
		else
			libs = Array.new
			libs.push(headerSearchPaths)
			libs.push(headerPath)
			bc.build_settings["HEADER_SEARCH_PATHS"] = libs
		end
		
		# framework paths
		frameworkSearchPaths = bc.build_settings["FRAMEWORK_SEARCH_PATHS"]
		if frameworkSearchPaths.class == Array
			frameworkSearchPaths.push(frameworkPath)
		else
			libs = Array.new
			libs.push(frameworkSearchPaths)
			libs.push(frameworkPath)
			bc.build_settings["FRAMEWORK_SEARCH_PATHS"] = libs
		end

		# lib paths
		librarySearchPaths = bc.build_settings["LIBRARY_SEARCH_PATHS"]
		if librarySearchPaths.class == Array
			librarySearchPaths.push(libraryPath)
		else
			libs = Array.new
			libs.push(librarySearchPaths)
			libs.push(libraryPath)
			bc.build_settings["LIBRARY_SEARCH_PATHS"] = libs
		end

		#
		bc.build_settings["APP_DISPLAY_NAME"] = appName
		bc.build_settings["PRODUCT_BUNDLE_IDENTIFIER"] = appPackage
		bc.build_settings["CODE_SIGN_STYLE"] = "Manual"
		bc.build_settings["DEVELOPMENT_TEAM"] = teamID
		if bc.name == "Debug"
			bc.build_settings["CODE_SIGN_IDENTITY"] = "iPhone Developer"
			bc.build_settings["PROVISIONING_PROFILE_SPECIFIER"] = provisioningProfileDebug
		else
			bc.build_settings["CODE_SIGN_IDENTITY"] = "iPhone Distribution"
			bc.build_settings["PROVISIONING_PROFILE_SPECIFIER"] = provisioningProfileRelease
		end

		configurations = frameworkList["configurations"]
		configurations.each do |k,v|
			bc.build_settings[k] = v
		end
    end

	#main
	if entitlements != nil && entitlements != "None"
		puts("\033[34mEntitlements Name: " + entitlements + " add ------------------------\033[0m")
		entitlementsPath = File.join(pathIosRuntime, entitlements.to_s())
		entitlementsFile = xcodeProject.new_file(entitlementsPath)
		puts "entitlementsPath: " + entitlementsPath

		attributes = {}
		# xcodeProject.targets.each do |target|
		# 	attributes[target.uuid] = {"SystemCapabilities" => {"com.apple.Push" => {"enabled" => 1}}}
		# 	target.add_file_references([entitlementsFile])
		# 	puts "Added to target: " + target.uuid
		# end
		attributes[xcodeTarget.uuid] = {"SystemCapabilities" => {"com.apple.Push" => {"enabled" => 1}}}
		xcodeProject.root_object.attributes['TargetAttributes'] = attributes
		xcodeProject.build_configurations.each do |config|
			config.build_settings.store("CODE_SIGN_ENTITLEMENTS", entitlements)
		end
		puts "Added entitlements file path: " + entitlements
	end

    embed = frameworkList["embed"]
    copyfilesBuildphases = nil
    
	frameworksGroup = xcodeProject.frameworks_group
	puts("    \033[35mGroup: " + frameworksGroup.name)
	Dir.foreach(pathSdkLib) do |file| 
      	if file!="." and file!=".." and file!=".DS_Store"
        	path = File.join(getRelativePath(pathSdkLib, pathIosRuntime), file.to_s())
        	puts("        \033[0mFrameworkPath: " + path)
			frameworkReference = frameworksGroup.new_reference(path)
			frameworksBuildphases = xcodeTarget.frameworks_build_phases
			frameworksBuildphases.add_file_reference(frameworkReference)
			if embed[file] == 1
				if copyfilesBuildphases == nil
					copyfilesBuildphases = xcodeTarget.new_copy_files_build_phase("Embed Frameworks")
    				copyfilesBuildphases.symbol_dst_subfolder_spec = :frameworks
				end
				buildFile = copyfilesBuildphases.add_file_reference(frameworkReference)
				buildFile.settings = { 'ATTRIBUTES' => ['CodeSignOnCopy', 'RemoveHeadersOnCopy'] }
			end
      	end
    end

    #system
	xcodeTarget.add_system_framework(frameworkList["framework"])
	xcodeTarget.add_system_library(frameworkList["library"])

	# ios
	iosGroup = xcodeProject["ios"]
	iosfiles = frameworkList["ios"]
	iosfiles.each do |k,v|
		path = k
        puts("        \033[0miosPath: " + path.to_s())
        fileReference = iosGroup.new_reference(path)
        if v != "h"
			xcodeTarget.source_build_phase.add_file_reference(fileReference, true)
		end
	end

	# res
	resourcesGroup = xcodeProject["Resources"]
	files = resourcesGroup.files
	files.each do |rf|
		xcodeTarget.resources_build_phase.remove_file_reference(rf)
	end
	resourcesGroup.clear()
	puts("    \033[35mGroup: " + resourcesGroup.name)
	Dir.foreach(pathProject) do |file|
		if file=="audio" or file.include?"package.assets" or file=="src" or file=="res"
      		path = File.join(getRelativePath(pathProject, pathIosRuntime), file.to_s())
        	puts("        \033[0mResourcePath: " + path.to_s())
        	resourcesReference = resourcesGroup.new_reference(path)
			xcodeTarget.add_resources([resourcesReference])
      	end
	end
	Dir.foreach(pathSdkRes) do |file|
      	if file!="." and file!=".." and file!=".DS_Store"
      		path = File.join(getRelativePath(pathSdkRes, pathIosRuntime), file.to_s())
        	puts("        \033[0mResourcePath: " + path.to_s())
        	resourcesReference = resourcesGroup.new_reference(path)
			xcodeTarget.add_resources([resourcesReference])
      	end
    end
    #xcassets = resourcesGroup["Images.xcassets"]
    #if xcassets
    #	xcassets.path = getRelativePath(pathSdkXcassets, pathIosRuntime)
	#	puts("    \033[0mxcassets.path:  " + xcassets.path)
    #end

    
    # save
	xcodeProject.save
	puts("\033[34mTarget Name: " + xcodeTarget.name + " Save------------------------\033[0m")
else
	puts("\033[31mTarget Not Find, name = " + targetName + "\033[0m")
end

