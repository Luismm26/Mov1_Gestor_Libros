import {Router} from 'express'
const router = Router()

import *as comentsCtrl from '../constrollers/coments.controller';

router.post('/', comentsCtrl.createComents)
router.get('/', comentsCtrl.getComents)
router.put('/:comentId', comentsCtrl.updateComents)
router.delete('/:comentId', comentsCtrl.deleteComents)

export default router;


