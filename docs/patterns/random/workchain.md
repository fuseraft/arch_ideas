# Workchain
A distributed computing pattern for separating work across a chain of services.

A chain is comprised of many services where one invokes the other along the chain in an asynchronous way that enables distributed event-driven design.

This decouples subsystem components to expand the surface area for telemetry.

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
         {
            "order": 1,
            "request": {
               "url": "amqp://{user}:{password}@{server}:{port}",
               "endpoint": "{queue}",
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

1. The Client adds messages to the Work Queue.
2. The ESB listens to the Work Queue.
3. The ESB initiates calls to the Service Gateway.
4. The Service Gateway invokes the Microservices.
5. The Microservice adds messages the Notification Queue.

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

1. The Notification Service listens to the Notification Queue.
2. The Notification Service adds messages to the Completion Queue.
3. The Client listens to the Completion Queue to know when work is completed.

```
   +--- [Notification Queue]
   |          +--- [Notification Service]
   |          |     +--- [Completion Queue]
   |          |     |                 +--- [Client]
   |          |     |                 | 
   v          v     |                 v     
+----+      +----+  v   +----+      +---+
| NQ | <=== | NS | ===> | CQ | <=== | C |
+----+   ^  +----+  ^   +----+   ^  +---+
         |          |            |
         +--- N_MSG +--- C_MSG   +--- C_MSG                                      
```

### Glossary

| Label | Term | Definition |
| --- | --- | --- |
| W_MSG | Work Message | Defines a work message. |
| N_MSG | Notification Message | Defines a notification message. |
| C_MSG | Completion Message | Defines a completion message. |
| CQ | Completion Queue | Stores C_MSG. |
| WQ | Work Queue | Stores W_MSG. |
| NQ | Notification Queue | Stores N_MSG. |
| C | Client | Adds a W_MSG to the WQ. |
| MS | Microservices | Adds a N_MSG to the NQ. |
| SG | Service Gateway | Invokes the MS, sending W_MSG to the MS. |
| ESB | Enterprise Service Bus | Listens to WQ. Invokes the SG, sending W_MSG to the SG. |
| NS | Notification Service |  Listens to NQ. Updates the WQ with N_MSG from the NQ. |
