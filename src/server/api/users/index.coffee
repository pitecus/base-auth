express = require 'express'
controller = require './controller'

router = express.Router()

router.get    '/',    controller.list
router.get    '/:id', controller.get
# router.post   '/',    controller.create
# router.put    '/:id', controller.update
# router.delete '/:id', controller.destroy

module.exports = router
