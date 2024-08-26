import app from './app'
import './database'

const ipAdress = '192.168.1.131';

app.listen(4000, '192.168.1.131', () =>{
    console.log('Server Listen on http://192.168.1.131:4000')

});



