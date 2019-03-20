### springboot-mybatis-pack
>springboot-mybatis-pack定制化打包springboot项目，并集成 mybatis

### 打包时应更改配置
>* 检查运行window操作系统位数，修改对应pom.xml,设置为操作系统相应位数
```xml
	<profile>
			<id>**</id>
			<properties>
				<profiles.active>**</profiles.active>
				<!-- 定义main class -->
				<mainClass>com.test.Main</mainClass>
				<!-- 定义window的操作系统位数,打包成系统服务用 -->
				<os>64</os>
			</properties>
			<activation>
				<activeByDefault>true</activeByDefault>
			</activation>
		</profile>
```

