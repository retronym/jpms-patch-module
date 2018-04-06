## JPMS `--patch-module` exploration

### Source layout
```
.
├── src
│   ├── main
│   │   └── java
│   │       └── example.a
│   │           ├── example
│   │           │   └── a
│   │           │       ├── MainRun.java
│   │           │       ├── Protected.java
│   │           │       └── internal
│   │           │           └── Public.java
│   │           └── module-info.java
│   └── test
│       └── java
│           └── example.a
│               └── example
│                   └── a
│                       └── Test.java
```

### Build Log

```
⚡ ./build.sh
+ rm -rf target/classes target/test-classes
+ mkdir -p target/classes target/test-classes
++ find src/main/java/example.a -name '*.java'
+ javac -d target/classes src/main/java/example.a/example/a/internal/Public.java src/main/java/example.a/example/a/MainRun.java src/main/java/example.a/example/a/Protected.java src/main/java/example.a/module-info.java
++ find src/test/java/example.a -name '*.java'
+ javac --add-modules=java.xml --add-reads example.a=java.xml --module=example.a --module-source-path=src/main/java:src/test/java -d target/test-classes --module-path=target/classes --patch-module example.a=target/classes src/test/java/example.a/example/a/Test.java
+ java --add-modules=java.xml --add-reads example.a=java.xml --module-path target/classes:target/test-classes --patch-module example.a=target/test-classes --module example.a/example.a.MainRun
MainRun
+ [[ -f target/test-classes/example.a/example/a/Test.class ]]
+ java --add-modules=java.xml --add-reads example.a=java.xml --module-path target/classes:target/test-classes --patch-module example.a=target/test-classes --module example.a/example.a.Test
Error: Could not find or load main class example.a.Test in module example.a
```