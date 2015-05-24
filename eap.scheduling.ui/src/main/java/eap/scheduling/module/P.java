package eap.scheduling.module;

/**
 * <p> Title: 应用URL资源路径列表</p>
 * <p> Description: </p>
 * @作者 chiknin@gmail.com
 * @创建时间 
 * @版本 1.00
 * @修改记录
 * <pre>
 * 版本       修改人         修改时间         修改内容描述
 * ----------------------------------------
 * 
 * ----------------------------------------
 * </pre>
 */
public interface P {
	
	/** 根路径 */
	String ROOT = "/";
	
	/** 错误页.404 */
	String ERROR_PAGE_404 = "/404.htm";
	/** 错误页.404 */
	String ERROR_PAGE_409 = "/409.htm";
	/** 错误页.500 */
	String ERROR_PAGE_500 = "/500.htm";
	
	String CONSOLE_SCHEDULING_INDEX = "/console/scheduling/index.htm";
	
	String CONSOLE_SCHEDULING_EDITJOB = "/console/scheduling/editJob.pjax";
	String CONSOLE_SCHEDULING_EDITTRIGGER = "/console/scheduling/editTrigger.pjax";
	
	String CONSOLE_SCHEDULING_GETSCHEDULERMETADATALIST = "/console/scheduling/getSchedulerMetaDataList.rest";
	String CONSOLE_SCHEDULING_EXECSCHEDULERCMD = "/console/scheduling/execSchedulerCmd.rest";
	String CONSOLE_SCHEDULING_GETSCHEDULEREXECUTINGJOBLIST = "/console/scheduling/getSchedulerExecutingJobList.rest";
	String CONSOLE_SCHEDULING_GETSCHEDULERJOBDETAILLIST = "/console/scheduling/getSchedulerJobDetailList.rest";
	String CONSOLE_SCHEDULING_EXECJOBCMD = "/console/scheduling/execJobCmd.rest";
	String CONSOLE_SCHEDULING_GETJOBDETAIL = "/console/scheduling/getJobDetail.rest";
	String CONSOLE_SCHEDULING_ADDJOB = "/console/scheduling/addJob.rest";
	String CONSOLE_SCHEDULING_GETSCHEDULERTRIGGERLIST = "/console/scheduling/getSchedulerTriggerList.rest";
	String CONSOLE_SCHEDULING_EXECTRIGGERCMD = "/console/scheduling/execTriggerCmd.rest";
	String CONSOLE_SCHEDULING_GETTRIGGER = "/console/scheduling/getTrigger.rest";
	String CONSOLE_SCHEDULING_ADDTRIGGER = "/console/scheduling/addTrigger.rest";
}