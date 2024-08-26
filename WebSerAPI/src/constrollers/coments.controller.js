import Comment from '../models/Coment'

export const createComents = async (req, res) => {
    
    const {nameLib, nameAuth, comLib, category, imgUrl} = req.body

    const newComent = new Comment({nameLib, nameAuth, comLib, category, imgUrl});

    const commentSaved = await newComent.save()


    res.status(201).json(commentSaved)

}

export const getComents = async (req, res) => {
    const comments = await Comment.find();
    res.json(comments)
}

export const updateComents = async (req, res) => {
    const updateComent = await Comment.findByIdAndUpdate(req.params.comentId, req.body,{
        new:true
    })
    res.status(200).json(updateComent)
}

export const deleteComents = async (req, res) => {
    const deleteComent = await Comment.findByIdAndDelete(req.params.comentId)
    res.status(204).json()
}