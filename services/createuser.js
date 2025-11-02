const mongoose = require('mongoose');
const { Schema } = mongoose;
const bcrypt = require('bcrypt');
const dbStructure = new Schema({
  name :{
      type : String,
      required : true,
  },
  email : {
    type : String,
    required : true,
    unique : true
  },
  password : {
    required : true,
    type : String
  },
  time : {
    type : Date,
    default : () => new Date(),
  },
},{strict : false})
dbStructure.pre('save',async function(){
            const user = this;
            if(this.isModified('password')){
            const hard = await bcrypt.genSalt(10);
            const hashpass = await bcrypt.hash(user.password,hard);
            
            user.password = hashpass;
            }
})
const finaldbStruc = mongoose.model('user',dbStructure);
class  userService{
      static async check_duplicate(email,res){
        try{
              const user = await finaldbStruc.findOne({email});
              if(user){
                return  {
                  duplicate : true
                }
                
              }
              if(!user){
                return {
                  duplicate : false,
                }
              }

        }
        catch(err){
                  throw err;
        }
      }
     static async registerUser(name,email,password){
        try{
              const newUser = new finaldbStruc({name,email,password});
              return await newUser.save();
        }
        catch(err){
          throw err;
        }
      }
      static async login(email,password){
        try{
        const user= await finaldbStruc.findOne({email});
        if(!user){  
          return {
            success : false,
          };
        }
        const ismatch = await bcrypt.compare(password,user.password);
        if(!ismatch){
          return {
            success : false
          };
        } 
        return {
          success : true,
        }
      }
      catch(err){
        throw err;
      }
      }
 static async demo(email,rank){
          const update = await finaldbStruc.updateOne({ email } , {$set : {rank}});
          return update;

 }
}
module.exports = { userService,finaldbStruc };
