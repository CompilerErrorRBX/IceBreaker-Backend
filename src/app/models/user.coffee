  # load the libs
mongoose = require 'mongoose'
bcrypt = require 'bcrypt-nodejs'
ObjectId = mongoose.Schema.Types.ObjectId


# define the schema
userSchema = mongoose.Schema(
  facebook:
    id: String
    token: String
    email: String
    name: String
    picture: String
    bio: String
    interests: [
      type: String
    ]
  local:
    email: String
    password: String)


# methods
# generating a hash
userSchema.methods.generateHash = (password) ->
  bcrypt.hashSync(password, bcrypt.genSaltSync(8), null)

# if the password is valid check
userSchema.methods.validPassword = (password) ->
  bcrypt.compareSync(password, @local.password)

# create the model for users and expose it to our app
module.exports = mongoose.model('User', userSchema)
