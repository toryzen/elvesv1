# Agent #
## 1.简介 ##

 
## 2.Thrift服务 ##

	service AgentService{
	    //检查是否存活
	    string aliveCheck()
	    //指令接收器[异步]
	    list<Reinstruct>  instructionInvokeAsync(1: list<Instruct> insList)
	    //指令接收器[同步]
	    Reinstruct instructionInvokeSync(1: Instruct ins)
	}

## 3.配置参数 ##

    AgengIP   = 127.0.0.1					#Agent IP地址

	zkList	  = 192.168.6.116:2181			#ZK LIST
	zkRoot    = /Elves						#ZK 根节点
	zkTimeout = 86400                       #ZK 超时时间

		
## 4.重点文件结构 ##


           

## 5.ZK操作与数据 ##
**Agent节点具体IP存储的数据**

	{"AgentType":"cSharpAgent","AgentVer":"1.0.0","StartTime":"2016/6/2 6:03:06","SelfTask":"[\"ts-ccccccccccccccccc\"]"}

1. AgentType   : Agent类型
1. AgentVer    : 当前Agent的版本
1. IpList      ：Agent的IP列表
1. StartTime  ：Agent的启动时间
1. LoadModule ：Agent已加载的模块列表
1. SelfTask   : Agent的自调用任务ID列表

## 5.设计思想 ##
1. Agent有两个版本，Python版与C#版，分别对应安装在Linux机器与Windows机器
1. 所有的Agent均注册到Zookeeper上，达到健康监测的作用，Agent自有的配置文件均存放在Zookeeper的本身节点目录下
1. 所有的模块均采用动态加载的方式
1. Agent不与核心数据库进行数据交互
1. C# Agent采用.net4.0构建console项目，python Agent采用python2.7构建python项目