## PostgreSQL Replication using Bucardo tool and  Docker Containers
### Step 1:

```
docker build -t bucardo .
```
### Step 2:

```
docker images 
```

```
REPOSITORY   TAG       IMAGE ID       CREATED          SIZE
bucardu      latest    0744b03ed7e0   21 minutes ago   379MB
ubuntu       focal     825d55fb6340   5 days ago       72.8MB
```

### Step 3:

```
docker run --name bucardu-container  bucardu
```
### Step 4:

```
docker ps 
```
```
CONTAINER ID   IMAGE     COMMAND                  CREATED          STATUS          PORTS     NAMES
2b7fd48e0b0b   bucardu   "/bin/bash -c /start…"   22 minutes ago   Up 22 minutes             bucardu-container
```
