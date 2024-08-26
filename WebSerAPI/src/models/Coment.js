import { Schema, model } from 'mongoose'

const comentSchema = new Schema({
    nameLib: String,
    nameAuth: String,
    comLib: String,
    category: String,
    imgUrl: String
    
},{
    timestamps: true,
    versionKey: false
})

export default model('Comment', comentSchema);