-- 注册窗口
local SetupView = class("SetupView", cc.load("mvc").ViewBase)

SetupView.RESOURCE_FILENAME = "Hall/setup.csb"

SetupView.RESOURCE_PREFIX = 'bind_'



local self_view = nil

function SetupView:onCreate()
	self.super.onCreate(self)
	print("my genxin le")
	self:BindButtonHanlder("bind_btn_music", createFunWrap(self.onClickSwitch,self))
	self:BindButtonHanlder("bind_btn_effect", createFunWrap(self.onClickSwitch,self))

	self:BindButtonHanlder("bind_btn_shake", createFunWrap(self.onClickSwitch,self))
	-- 
	self:BindButtonHanlder("bind_btn_switch", createFunWrap(self.onClickSwitchAccount,self))

	--修改密码
	self:BindButtonHanlder("bind_btn_modif_pwd", createFunWrap(self.onClickPwd,self))
	self.bind_btn_modif_pwd:setVisible(G_PlayerData:IsBindPhone());
	-- MsgMap:AddMsgCb(createMsgCB(MsgId.RegisterPhpneReq,self.onRecMsg,self))
	-- MsgMap:AddMsgCb(createMsgCB(MsgId.IDCodeReq,self.onRecCodeMsg,self))
	self:BindButtonHanlder("bind_panel_root", createFunWrap(self.onClickClose,self))

	self:BindButtonHanlder("bind_btn_privacy", createFunWrap(self.onClickPrivacy,self))
	self:BindButtonHanlder("bind_btn_service", createFunWrap(self.onClickSerice,self))
	--self:BindButtonHanlder("bind_btn_declare", createFunWrap(self.onClickDeclare,self))
	--self:BindButtonHanlder("bind_btn_help", createFunWrap(self.onClickHelp,self))
	self.bind_btn_declare:setVisible(false);
	self.bind_btn_help:setVisible(false);

	self_view = self 
end

function SetupView:onClickPrivacy(btnNode)
	print("btn node :",btnNode:getName())
	local view = App:createView("SystemView")
	view:showSystem(G_CONFIG.SYSTEM_PRIVACY)
	self_view:addChild(view)
end

function SetupView:onClickSerice(btnNode)
	print("btn node :",btnNode:getName())
	local view = App:createView("SystemView")
	view:showSystem(G_CONFIG.SYSTEM_SERVICE)
	self_view:addChild(view)
end

function SetupView:onClickDeclare(btnNode)
	print("btn node :",btnNode:getName())
	local view = App:createView("SystemView")
	view:showSystem(G_CONFIG.SYSTEM_DECLARE)
	self_view:addChild(view)
end

function SetupView:onClickHelp(btnNode)
	print("btn node :",btnNode:getName())
	local view = App:createView("SystemView")
	view:showSystem(G_CONFIG.SYSTEM_HELP)
	self_view:addChild(view)
end


function SetupView:onClickPwd(btnNode)
	print("btn node :",btnNode:getName())
	UIManager:showNode(self_view:getParent(), "ModifyPwdView")

	self_view:removeSelf()
end 

function SetupView:onClickSwitchAccount(btnNode)
	print("btn node :",btnNode:getName())
	
	UIManager:showNode(self_view:getParent(), "SwitchAccount")
	self_view:removeSelf()
end

function SetupView:onClickClose(btnNode)
	print("btn node :",btnNode:getName())

	self_view:removeSelf()
end

function SetupView:onClickSwitch(btnNode)
	local _btnNodeName = btnNode:getName()
	print("btn name : ",_btnNodeName)
	local state = self_view:getSwitchState(btnNode)

	local new_state = true

	if state then
		new_state = false
	end

	self_view:changeSwitchBtn(_btnNodeName, new_state)

end 

function SetupView:getSwitchState(btnNode)
	local mark = btnNode:getChildByName("img_mark")
	local size = btnNode:getContentSize()
	local mark_size = mark:getContentSize()
	local posx,posy  = mark:getPosition()

	if posx < size.width*0.5 then
		return true 
	else 
		return false 
	end
end

function SetupView:changeSwitchBtn(_btnNodeName,_isOn)
	local btn = self_view[_btnNodeName]
	local on = btn:getChildByName("img_word_on")
	local off = btn:getChildByName("img_word_off")
	local mark = btn:getChildByName("img_mark")
	local size = btn:getContentSize()
	local mark_size = mark:getContentSize()
	local pos = mark:getPosition()

	if _isOn then
		mark:runAction(cc.MoveTo:create(0.05, cc.p(mark_size.width * 0.5 +3.0, size.height * 0.5)))
		btn:loadTextureNormal("Hall/img/bg_guan@3x.png")
		btn:loadTexturePressed("Hall/img/bg_guan@3x.png")
	else 
		mark:runAction(cc.MoveTo:create(0.05, cc.p(size.width - mark_size.width * 0.5 - 3.0, size.height * 0.5)))
		btn:loadTextureNormal("Hall/img/bg_kai@3x.png")
		btn:loadTexturePressed("Hall/img/bg_kai@3x.png")
	end
	
	if _btnNodeName == "bind_btn_music" then
		

	elseif _btnNodeName == "bind_btn_effect" then

	elseif _btnNodeName == "bind_btn_shake" then

	end

end

function SetupView:onRecMsg(_msg)
	UtilsCocos:printTable(_msg)

	if _msg ~= nil then
		if _msg["errInfo"] ~= nil then
			print(_msg["errInfo"])
		else
			

			self_view:removeSelf()
		end
	end
end

function SetupView:onClose()
	self.super.onClose(self)
	self_view = nil 
end

function SetupView:onShow()
	self.super.onShow(self)

	self["bind_panel_dialog"]:setScale(0.1)
	self["bind_panel_dialog"]:runAction(cc.Sequence:create(cc.ScaleTo:create(0.15,1.15),cc.ScaleTo:create(0.1,1.0)))

	self_view:changeSwitchBtn("bind_btn_music",false)
	self_view:changeSwitchBtn("bind_btn_effect",true)
	self_view:changeSwitchBtn("bind_btn_shake",false)
	
end

return SetupView
