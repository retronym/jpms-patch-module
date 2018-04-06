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
+ javac --add-modules=java.xml --add-reads example.a=java.xml -d target/test-classes --patch-module example.a=src/test/java/example.a --module-path=target/classes src/test/java/example.a/example/a/Test.java
+ java --module-path target/classes --module example.a/example.a.MainRun
MainRun
+ [[ -f target/test-classes/example/a/Test.class ]]
+ java --add-modules=java.xml --add-reads example.a=java.xml --module-path target/classes --patch-module example.a=target/test-classes --module example.a/example.a.Test
Test
```
