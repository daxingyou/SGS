local ViewBase = require("app.ui.ViewBase")
local HorseView = class("HorseView", ViewBase)
local RedPointHelper = require("app.data.RedPointHelper")
local WayFuncDataHelper = require("app.utils.data.WayFuncDataHelper")

function HorseView:ctor()
    local resource = {
		file = Path.getCSB("HorseView", "horse"),
		size = G_ResolutionManager:getDesignSize(),
		binding = {
			_btnRace = {
				events = {{event = "touch", method = "_onRaceClick"}}
			},
			_buttonHorseList = {
				events = {{event = "touch", method = "_onListClick"}}
			},
			_buttonHorseJudge = {
				events = {{event = "touch", method = "_onJudgeClick"}}
			},
			_buttonHorseShop = {
				events = {{event = "touch", method = "_onShopClick"}}
            },
            _btnHorsePhoto = {
                events = {{event = "touch", method = "_onHorsePhotoClick"}}
            },
		}
	}
	HorseView.super.ctor(self, resource, 115)
end

function HorseView:onCreate()
	self._topBar:setImageTitle("txt_sys_com_horse")
	local TopBarStyleConst = require("app.const.TopBarStyleConst")
	self._topBar:updateUI(TopBarStyleConst.STYLE_HORSE)

	self:_swapImageByI18n()
end

function HorseView:onEnter()
    
    self._signalRedPointUpdate = G_SignalManager:add(SignalConst.EVENT_RED_POINT_UPDATE, handler(self, self._redPointUpdate))
	self:_updateBtnRP()
end

function HorseView:onExit()
    self._signalRedPointUpdate:remove()
    self._signalRedPointUpdate = nil
end

function HorseView:_onHorsePhotoClick()
    local popupHorseKarma = require("app.scene.view.horseTrain.PopupHorseKarma").new(self)
	popupHorseKarma:openWithAction()
end

function HorseView:_onRaceClick()
    G_SceneManager:showScene("horseRace")
end

function HorseView:_onListClick()
    G_SceneManager:showScene("horseList")
end

function HorseView:_onJudgeClick()
	G_SceneManager:showScene("horseJudge")
end

function HorseView:_onShopClick()
	WayFuncDataHelper.gotoModuleByFuncId(FunctionConst.FUNC_HORSE_SHOP)
end

function HorseView:_updateBtnRP()
	local reach1 = RedPointHelper.isModuleReach(FunctionConst.FUNC_HORSE_LIST) --我的战马
	self._imageHorseListRP:setVisible(reach1)

	local reach2 = not require("app.scene.view.horseRace.HorseRaceHelper").isRewardFull() --马跃檀溪
	self._imageHorsePlayRP:setVisible(reach2)

	local reach3 = RedPointHelper.isModuleReach(FunctionConst.FUNC_HORSE_JUDGE) --相马
	self._imageHorseJudgeRP:setVisible(reach3)

	local reach4 = false --战马商店
    self._imageHorseShopRP:setVisible(reach4)
    
    -- local horsePhotoValid = G_UserData:getHorse():isHorsePhotoValid()          --战马图鉴
    local horsePhotoValid = RedPointHelper.isModuleSubReach(FunctionConst.FUNC_HORSE_BOOK, "horseBook")
    self._imageHorsePhotoRP:setVisible(horsePhotoValid)
end

function HorseView:_redPointUpdate()
    local horsePhotoValid = G_UserData:getHorse():isHorsePhotoValid()          --战马图鉴
    self._imageHorsePhotoRP:setVisible(horsePhotoValid)
end
-- i18n change lable
function HorseView:_swapImageByI18n()
	if not Lang.checkLang(Lang.CN) then
		local UIHelper  = require("yoka.utils.UIHelper")

		local image1 = UIHelper.seekNodeByName(self._buttonHorseJudge,"Image_153")
		local labe1 = UIHelper.swapWithLabel(image1,{ 
			 style = "horse_1", 
			 text = Lang.getImgText("txt_horse_choice") ,
		})
		labe1:setTextHorizontalAlignment(cc.TEXT_ALIGNMENT_CENTER)

		local image2 = UIHelper.seekNodeByName(self._buttonHorseList,"Image_153")
		local labe2 = UIHelper.swapWithLabel(image2,{ 
			 style = "horse_1", 
			 text = Lang.getImgText("txt_horse_mine") ,
		})
		labe2:setTextHorizontalAlignment(cc.TEXT_ALIGNMENT_CENTER)

		local image3 = UIHelper.seekNodeByName(self._btnRace,"Image_153")
		local labe3 = UIHelper.swapWithLabel(image3,{ 
			 style = "horse_1", 
			 text = Lang.getImgText("txt_horse_play") ,
		})
		labe3:setTextHorizontalAlignment(cc.TEXT_ALIGNMENT_CENTER)

		local image4 = UIHelper.seekNodeByName(self._buttonHorseShop,"Image_153")
		local labe4 = UIHelper.swapWithLabel(image4,{ 
			 style = "horse_1", 
			 text = Lang.getImgText("txt_horse_shop") ,
		})
		labe4:setTextHorizontalAlignment(cc.TEXT_ALIGNMENT_CENTER)


		local imageNameBg = UIHelper.seekNodeByName(self._btnHorsePhoto,"ImageNameBG")
		local image153 = UIHelper.seekNodeByName(self._btnHorsePhoto,"Image_153")

		image153:retain()
		image153:removeFromParent()
		self._btnHorsePhoto:addChild(image153)
		image153:release()

		self._imageHorsePhotoRP:retain()
		self._imageHorsePhotoRP:removeFromParent()
		self._btnHorsePhoto:addChild(	self._imageHorsePhotoRP)
		self._imageHorsePhotoRP:release()

	

		local labe5 = UIHelper.swapWithLabel(imageNameBg,{ 
			 style = "icon_txt_3", 
			 text = Lang.getImgText("txt_main_enter6_horse_tujian") ,
			 offsetY = -22,
			 anchorPoint = cc.p(0.5,1)
		},false)
		labe5:setTextHorizontalAlignment(cc.TEXT_ALIGNMENT_CENTER)
		labe5:getVirtualRenderer():setLineSpacing(-7)
		
		
	
	end
	if Lang.checkHorizontal() then
		local UIHelper  = require("yoka.utils.UIHelper")
		local list = {
			{name = "_btnRace",pos = cc.p(220,12),red = "_imageHorsePlayRP"},
			{name = "_buttonHorseList",pos = cc.p(260,20),red = "_imageHorseListRP"},
			{name = "_buttonHorseJudge",pos = cc.p(180,8),red = "_imageHorseJudgeRP"},
			{name = "_buttonHorseShop",pos = cc.p(155,-10),red = "_imageHorseShopRP"},
		}
		for i, v in ipairs(list) do
			local img = UIHelper.seekNodeByName(self[v.name],"ImageNameBG")
			img:setScale9Enabled(true)
			img:setCapInsets(cc.rect(18,10,1,1))
			img:loadTexture(Path.getGuildRes("img_juntuan_txtbg01_h"))
			img:setPosition(v.pos)
			local label = UIHelper.seekNodeByName(img,"Image_153")
			label:setAnchorPoint(0.5,0.5)
			local width = label:getContentSize().width+60
			img:setContentSize(cc.size(width,28))
			label:setPosition(width/2,14)
			label:ignoreContentAdaptWithSize(true)
			self[v.red]:setPosition(width,28)
		end
	end
end

return HorseView

