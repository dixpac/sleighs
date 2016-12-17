module ActionController
  autoload :Base, 'action_controller/base'
  autoload :Callbacks, 'action_controller/callbacks'
  autoload :Metal, 'action_controller/metal'
  autoload :ImplicitRender, "action_controller/implicit_render"
  autoload :RequestForgeryProtection, 'action_controller/request_forgery_protection'
end
