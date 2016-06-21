# AppSDK #
## 1.简介 ##
![](http://gitlib.dev.gyyx.cn/dev/elves/raw/develop/designer/snapshot/module-f.jpg)


## 2.Thrift服务 ##

    //Module提供的接口,此接口主要将Processor暴露给Scheduler
	service ModuleService{
		Reinstruct runProcessor(1:Reinstruct reins)
	}


## 3.方法接口 ##


    interface Worker {
		/*
		加载到Agent上，执行相应的业务逻辑
			id		:指令ID
			param 	: 指令参数
		*/
	    public String Exec(string id, Dictionary<string,string> param) ;
    }


    interface Processor {
		/*
			标示此任务是否成功完成，此地方用于有依赖的队列任务
		*/
		public bool flag = true;
		/*
			接收Worker返回的数据，并进行业务处理
			id		:指令ID
			param 	: 指令参数
			agentIP : 执行worker的AgentIP
			costtime: worker执行花费时间
			message : worker的返回内容
		*/
	    public String Exec(string id, Dictionary<string,string> param,string agentIp,int costtime,string message) ;
    }


## 4.配置参数 ##

	name = TestModule						#模块名称
	version = 1.0.0 						#模块版本

	ip = 0.0.0.0 							#当前服务器的IP(需要Scheduler可以访问到)
	port = 0000  							#Thrift的开放端口(需要Scheduler可以访问到)

	zkList = 1.1.1.1,2.2.2.2,3.3.3.3 		#系统的Zookeeper列表
	zkRoot = /Elves 						#Elves在ZK的根节点
	zkTimeout = 86400 						#Zk超时时间

	ftpIp = 127.0.0.1						#Worker上传的FTP地址			
	ftpPort = 21							#Worker上传的FTP端口
	ftpIp = admin							#Worker上传的FTP账号			
	ftpPort = 123456						#Worker上传的FTP密码
			
	mode = debug/product					#DEBUG模式为本地调试模式，Worker执行后会直接发送给Processor处理
	debugParam = {}							#JSON化的DEBUG参数
	

## 5.重点文件结构 ##

	.
	├─csharp-module
	│   ├─Module			@模块主程序
	│   │  ├─Program.cs			#Module执行主入口
	│   │  ├─App.config			#Module配置文件
	│   │  └─Util
	│   │
	│   ├─Module_Processor	@Processor
	│   │  └─Processor.cs		#Processor模块逻辑
	│   │
	│   ├─Module_Takser		@Tasker
	│   │  └─Tasker.cs			#Tasker模块逻辑
	│   │
	│   └─Module_Worker		@Worker
	│      └─Worker.cs			#Worker模块逻辑
	│   
	└─python-module
	    ├─run.py			@模块主程序:Module执行主入口
	    ├─setting.ini		#Module配置文件
        │
	    ├─lib				@Processor
	    │  └─thrift					#thrift包
        │
	    ├─Module_Processor	@Processor包
	    │  └─processor.py			#Processor模块逻辑
        │
	    ├─Module_Takser		@Tasker包
	    │  └─tasker.py			#Tasker模块逻辑
        │
	    └─Module_Worker		@Worker包
	       └─worker.py			#Worker模块逻辑

## 5.ZK操作与数据 ##

**Module节点具体IP存储数据**

	{"Version":"10010"}
    
存储该Module的版本号


## 6.设计思想 ##

1. 每个模块均需要配备Worker、Processor、Tasker，Module作为一个单独程序运行，其中Worker为单独的一个包/DLL
1. Worker加载至Agent，执行相应节点机器逻辑，如检测线程数,进程数,负载情况等等
1. Processor接收由Schedualr中转的数据信息，并作后续的逻辑处理
1. Tasker作为Deamon进程运行，用于定时触发增加队列任务
1. 所有的模块信息注册至Zookeeper