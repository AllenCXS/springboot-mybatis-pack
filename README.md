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
### 注意:``本项目采用的是mysql数据库,如需换数据库请更换相关依赖及数据库配置。另本项目采用jap自动生成表,因此请先自行创建数据库``
