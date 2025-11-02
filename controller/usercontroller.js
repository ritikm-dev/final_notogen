   const { userService } = require('../services/createuser');
   const db = require('../dbconfig/config');
const { json } = require('body-parser');
   exports.register = async(req, res, next)=>{
      try{
            const name = req.body.name; 
            const email = req.body.email;
            const password = req.body.password;
            const duplicatecheck = await userService.check_duplicate(email);
            if(duplicatecheck.duplicate){
               return res.status(409).json(duplicatecheck);
            }
            const successRes = await userService.registerUser(name,email,password);
            if(successRes){
              return res.status(200).json(successRes);
             
            }
             else if(!successRes){
                  return res.status(401).json({ message : "Registration Failed",...successRes});
               }
            }
            catch(err){
               next(err);
            }

            
   }
   exports.login = async (req,res,next)=>{
      const email = req.body.email;
      const password = req.body.password;
      const result = await userService.login(email, password);

  if (result.success) {
    return res.status(200).json(result);
  }

   else if(!result.success) return res.status(401).json(result);
   }
   exports.demo = async (req,res,next)=>{
      try{
      const result = await userService.demo;
      if(result){
               res.status(200).json(result);        
      }
      
   }
   catch(err){
      throw err;
   }
   }
    