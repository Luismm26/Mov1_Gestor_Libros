import express from 'express'
import morgan from 'morgan'
import pkg from "../package.json";

import comentsRoutes from './routes/coments.routes'

const app = express()

app.set('pkg', pkg);

app.use(express.json());

app.use(morgan('dev'));

app.get('/', (req, res)=> {
    res.json({
        author: app.get('pkg').author,
        description: app.get('pkg').description,
        version: app.get('pkg').version,
        
    })
})

app.use('/coments',comentsRoutes)

export default app; 
