#= require action_cable
# = require_self
# = require_tree ./channels

window.App ||= {}
window.App.cable = ActionCable.createConsumer()