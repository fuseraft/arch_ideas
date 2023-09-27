# Workflow Chaining
A distributed computing pattern for separating work across a chain of services.

A chain is comprised of many services where one invokes the other along the chain in an asynchronous way that enables distributed event-driven design.

## Structure

### Messages

#### Work Message
The work message contains work to be done. 

Any time a client needs work performed, it generates a request object (following Factory or Builder pattern) that is serialized into a protobuffer or JSON object. 

The message should contain all required information for the Enterprise Service Bus (a reverse proxy for handling work messages from clients) to orchestrate the flow.

##### Example
```json
{
   "work_message": {
      "hash": "MD5CheckSum",
      "items": [
         // The first work item, invokes an API endpoint to do work. 
         {
            "order": 0,
            "request": {
               "url": "https://{domain}",
               "endpoint": "/{application}/api/{module}/{function}",
               "type": "HTTPS",
               "method": "POST",
               "payload": "{jsonOrProtoBufferData}",
            },
         },
         // The second work item, generates completion message on message queue.
         {
            "order": 1,
            "request": {
               "url": "amqp://{user}:{password}@{server}:{port}",
               "endpoint": "completion-queue",
               "type": "AMQP",
               "method": "publish",
               "payload": "{jsonOrProtoBufferData}",
            }
         }
      ]
   }
}
```

#### Notification Message
The notification message is to notify the notification service that work has be completed and is ready to move to the completion queue.

##### Example
```json
{
   "notification_message": {
      "hash": "{MD5CheckSum}",
      "items": [
         {
            "order": 0,
            "response": {
               "error": false,
               "ok": true,
               "data": "{responseData}",
               "metadata": "{responseMetaData}",
            }
         }
      ]
   }
}
```

#### Completion Message
The completion message is to notify subscribers to the completion queue that work has been completed.

##### Example
```json
{
   "completion_message": {
      "hash": "{MD5CheckSum}",
      "items": [
         {
            "order": 0,
            "response": {
               "error": false,
               "ok": true,
               "data": "{responseData}",
               "metadata": "{responseMetaData}",
            }
         }
      ]
   }
}
```

## Flow

### Egress

1. The C add messages to the WQ.
2. The ESB listens to the WQ and initiates calls to the SG.
3. The SG invokes the MS.
4. The MS adds items the NQ.
5. The NS listens to the NQ and updates the WQ.

```
                         +--- [Enterprise Service Bus]
                         |            +--- [Service Gateway]
  +--- [Client]          |            |           +--- [Microservices]
  |    +--- W_MSG        |            |           |       
  |    |                 |            |           |     +--- N_MSG  +---N_MSG
  v    |                 v            v           v     |           |
+---+  v   +----+      +-----+      +----+      +----+  v   +----+  v   +----+
| C | ===> | WQ | <=== | ESB | ===> | SG | ===> | MS | ===> | NQ | <=== | NS | 
+---+      +----+   ^  +-----+   ^  +----+  ^   +----+      +----+      +----+
             ^      |            |          |                 ^           ^
             |      +--- W_MSG   +--- HTTPS +--- HTTPS        |           |
             |                                                |           |
             +--- [Work Queue]                                |           +--- [Notification Service]
                                                              +--- [Notification Queue]
```

### Ingress

1. The NS updates messages in the WQ.
2. The C listens to WQ for these updates to know when work is completed.

```
        +--- C_MSG   +--- C_MSG
        |            |
+----+  v   +----+   v  +---+
| NS | ===> | CQ | <=== | C |
+----+      +----+      +---+
  ^            ^          ^
  |            |          |
  |            |          +--- [Client]
  |            +--- [Completion Queue]
  +--- [Notification Service]
```
### Glossary
1. **W_MSG**: Work Message
   1. Defines a work message.
2. **N_MSG**: Notification Message
   1. Defines a notification message.
3. **C_MSG**: Completion Message
   1. Defines a completion message.
4. **CQ**: Completion Queue
   1. Stores C_MSG.
5. **WQ**: Work Queue
   1. Stores W_MSG.
6. **NQ**: Notification Queue
   1. Stores N_MSG.
7. **C**: Client
   1. Adds a W_MSG to the WQ.
8. **MS**: Microservices
   1. Adds a N_MSG to the NQ.
9.  **SG**: Service Gateway
   1. Invokes the MS, sending W_MSG to the MS.
10. **ESB**: Enterprise Service Bus
   1. Listens to WQ.
   2. Invokes the SG, sending W_MSG to the SG.
11. **NS**: Notification Service
   1. Listens to NQ.
   2. Updates the WQ with N_MSG from the NQ.
