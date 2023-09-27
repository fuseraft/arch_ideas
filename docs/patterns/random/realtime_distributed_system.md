### 10K-foot view: real-time distributed system.

```
+-----------------+   HTTPS   +-------------+    HTTPS    +---------------------------+
| Enterprise Apps |---------->| API Gateway |<------------| Long Running Backend Apps |
+-----------------+           +-------------+             +---------------------------+
                                  |    |                                |
+-----------+        HTTPS        |    | HTTPS                          | AMQP
| REST APIs |<--------------------+    |                                |
+-----------+                          v                                v
      |                          +-----------+      AMQP        +----------------+
      | TCP                      | REST APIs |----------------> | Message Queues |
      v                          +-----------+                  +----------------+
+-------------+
| Databases,  |    TCP    +---------------------------+
| Warehouses, |<----------| Long Running Backend Apps |
| Cache       |           +---------------------------+ 
+-------------+
```
