import mongoose from 'mongoose'

mongoose.connect("mongodb://localhost/companydb")
   

    .then(db => console.log('Db is connect'))
    .catch(error => console.log(error))