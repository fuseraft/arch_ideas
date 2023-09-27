### Checking JDK versions

Checking current version of `java`.

```bash
java -version
```

Checking current version of `javac`.

```bash
javac -version
```

### Switching JDK Versions

List the available versions with `update-java-alternatives`.

```bash
sudo update-java-alternatives --list
```

Select the current version to use with `update-alternatives`.

```bash
sudo update-alternatives --config java
```

Do the same for `javac`.

```bash
sudo update-alternatives --config javac
```

### Configuring `JAVA_HOME`

If `JAVA_HOME` is not set correctly, run the command below to set from current default `Java` configured.

```bash
export JAVA_HOME=$(readlink -f /usr/bin/java | sed "s:bin/java::")
```

For `JRE`, use:

```bash
export JAVA_HOME=$(readlink -f /usr/bin/java | sed "s:jre/bin/java::")
```

Persistence can be achieved by placing the export command in your .bashrc or /etc/profilefile.

```bash
$ vim ~/.bashrc
export JAVA_HOME=$(readlink -f /usr/bin/java | sed "s:bin/java::")
```
