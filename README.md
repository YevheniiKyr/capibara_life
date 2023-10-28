# How to run app
You need to have ruby 3.1.3 or any compatible version.
To start server go to the project directory
and run in terminal 
- rails start
 The server will be listening on PORT 3000 by default.

# Description
The server was written for social media app with capybaras.
This API has RESTful design
Database include models
- Capibara  
- Connection - connection between Capibaras
- Connection_type - capibaras can be "friends" or "spouse".
- User 
CRUD operations implemented for each model

# Endpoints

1)Capibaras

/capibaras 
- post : {description, weight, money, name, power, image}
- delete, 
- get
- 
/capibaras/:id 
- put : {description, weight, money, name, power, image}, 
- delete, 
- get

2)Connection_types

/connection_types 
- post
- get

/connection_types/:id
- get

3)Connections

/connections
- get
- post : {capi_1, capi_2, connection_type_id, status}

/connections/:id
- get 
- delete
- post : {status}

4)Users

/users 
- post : {name, role, password}
- get

/login
- post : {name, password}

/auth/check
- post
