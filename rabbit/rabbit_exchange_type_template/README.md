# RabbitMQ {{type}} Exchange Type

```
    增加exchange-type自定义，新添加的exchange-type为`x-{{type}}`,
```

## 1.Docker代码编译
### 1.1 依赖环境

* 环境: `Docker-2.3.0.5 stable, Linux bash`
* Dockerfile文件依赖: `elixir 1.11.4(对应erlang 23.0, rabbitmq-server-v3.8.15)`

### 1.2 执行流程

* Build Docker Image `sh tool.sh build_docker`
* 编译代码并启动Rabbitmq broker `sh tool.sh make`
* 执行结果：
   ```shell

              RabbitMQ 3.8.15
        
              Copyright (c) 2007-2021 VMware, Inc. or its affiliates.
            
              Licensed under the MPL 2.0. Website: https://rabbitmq.com

  Doc guides: https://rabbitmq.com/documentation.html
  Support:    https://rabbitmq.com/contact.html
  Tutorials:  https://rabbitmq.com/getstarted.html
  Monitoring: https://rabbitmq.com/monitoring.html

  Logs: /tmp/rabbitmq-test-instances/rabbit@cc8fc21fdd19/log/rabbit@cc8fc21fdd19.log
        /tmp/rabbitmq-test-instances/rabbit@cc8fc21fdd19/log/rabbit@cc8fc21fdd19_upgrade.log

  Config file(s): /tmp/rabbitmq-test-instances/test.config

  Starting broker... completed with 4 plugins.

   ```
* 编译后插件位置: `plugins/{{name}}-*.ez`


## 2. 插件如何安装

  拷贝插件到Rabbitmq对应的plugins目录,一般存放在`/usr/lib/rabbitmq/plugins`,如果没有该目录可以通过命令查询`rabbitmq-plugins directories -s`
  文件存放好后可以通过命令启动插件：`rabbitmq-plugins enable  {{name}}`
  

## 3. 裸机上如何执行

* 安装: `erlang 22.3以上版本,elixir 1.11.4版本。对应rabbitmq-server v3.18.5`
* 具体执行步骤可以看Dockerfile和tool.sh