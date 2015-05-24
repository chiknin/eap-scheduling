package eap.scheduling.module.console.scheduling.clr;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.quartz.SchedulerException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import eap.base.BaseController;
import eap.comps.scheduling.JobDetailVO;
import eap.comps.scheduling.MetaDataVO;
import eap.comps.scheduling.SchedulerManager;
import eap.comps.scheduling.TriggerVO;
import eap.scheduling.module.P;
import eap.util.JsonUtil;
import eap.util.StringUtil;

/**
 * <p> Title: </p>
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
@Controller
public class SchedulingCLR extends BaseController {
	
	@RequestMapping(P.CONSOLE_SCHEDULING_INDEX)
	public String index(Model model, HttpServletResponse response) throws Exception {
		return "schedulingIndex";
	}
	
	@RequestMapping(P.CONSOLE_SCHEDULING_EDITJOB)
	public String editJob(Model model, HttpServletResponse response) throws Exception {
		transferAttribute("scheduler");
		transferAttribute("jobGroup");
		transferAttribute("jobName");
		return "editJob";
	}
	@RequestMapping(P.CONSOLE_SCHEDULING_EDITTRIGGER)
	public String editTrigger(Model model, HttpServletResponse response) throws Exception {
		transferAttribute("scheduler");
		transferAttribute("jobGroup");
		transferAttribute("jobName");
		transferAttribute("triggerGroup");
		transferAttribute("triggerName");
		return "editTrigger";
	}
	
	@RequestMapping(P.CONSOLE_SCHEDULING_GETSCHEDULERMETADATALIST)
	public @ResponseBody Object getSchedulerMetaDataList() {
		List<String> schedulerNames = SchedulerManager.getSchedulerNames();
		List<MetaDataVO> metaDataVOList = new ArrayList<MetaDataVO>(schedulerNames.size());
		for (String schedulerName : schedulerNames) {
			metaDataVOList.add(SchedulerManager.getMetaData(schedulerName));
		}
		
		return metaDataVOList;
	}
	
	@RequestMapping(P.CONSOLE_SCHEDULING_EXECSCHEDULERCMD)
	public @ResponseBody Object execSchedulerCmd() throws SchedulerException {
		String schedulerName = this.getParameter("scheduler");
		String cmd = this.getParameter("cmd");
		
		return SchedulerManager.execSchedulerCmd(schedulerName, cmd);
	}
	
	@RequestMapping(P.CONSOLE_SCHEDULING_GETSCHEDULEREXECUTINGJOBLIST)
	public @ResponseBody Object getSchedulerExecutingJobList() throws SchedulerException {
		String schedulerName = this.getParameter("scheduler");
		
		return SchedulerManager.getCurrentlyExecutingJobs(schedulerName);
	}
	
	@RequestMapping(P.CONSOLE_SCHEDULING_GETSCHEDULERJOBDETAILLIST)
	public @ResponseBody Object getSchedulerJobDetailList() throws SchedulerException {
		String schedulerName = this.getParameter("scheduler");
		String likeJobGroup = this.getParameter("likeJobGroup");
		String likeJobName = this.getParameter("likeJobName");
		
		return SchedulerManager.getJobDetailList(schedulerName, likeJobGroup, likeJobName);
	}
	
	@RequestMapping(P.CONSOLE_SCHEDULING_EXECJOBCMD)
	public @ResponseBody Object execJobCmd() throws SchedulerException {
		String schedulerName = this.getParameter("scheduler");
		String jobName = this.getParameter("jobName");
		String jobGroup = this.getParameter("jobGroup");
		String cmd = this.getParameter("cmd");
		String dataJsonStr = this.getParameter("data");
		Map<String, Object> data = null;
		if (StringUtil.isNotBlank(dataJsonStr)) {
			data = JsonUtil.parseJson(dataJsonStr, HashMap.class);
		}
		
		return SchedulerManager.execJobCmd(schedulerName, jobName, jobGroup, cmd, data);
	}
	
	@RequestMapping(P.CONSOLE_SCHEDULING_GETJOBDETAIL)
	public @ResponseBody Object getJobDetail() throws SchedulerException {
		String schedulerName = this.getParameter("scheduler");
		String jobName = this.getParameter("jobName");
		String jobGroup = this.getParameter("jobGroup");
		
		return SchedulerManager.getJobDetail(schedulerName, jobName, jobGroup);
	}
	
	@RequestMapping(P.CONSOLE_SCHEDULING_ADDJOB)
	public @ResponseBody Object addJob() throws SchedulerException {
		try {
			String schedulerName = this.getParameter("scheduler");
			JobDetailVO jobDetailVO = this.getParameter(JobDetailVO.class, false);
//			Map<String, Object> jobDataMap = JsonUtil.parseJson(this.getRequest().getParameter("jobParams"), HashMap.class);
//			jobDetailVO.setJobDataMap(jobDataMap);
		
			SchedulerManager.addJob(schedulerName, jobDetailVO);
		} catch (Exception e) {
			logger.error(e.getMessage(), e);
			return e.getMessage();
		}
			
		return true;
	}
	
	@RequestMapping(P.CONSOLE_SCHEDULING_GETSCHEDULERTRIGGERLIST)
	public @ResponseBody Object getSchedulerTriggerList() throws SchedulerException {
		String schedulerName = this.getParameter("scheduler");
		String jobName = this.getParameter("jobName");
		String jobGroup = this.getParameter("jobGroup");
		
		return SchedulerManager.getTriggerVOListOfJob(schedulerName, jobName, jobGroup);
	}
	
	@RequestMapping(P.CONSOLE_SCHEDULING_EXECTRIGGERCMD)
	public @ResponseBody Object execTriggerCmd() throws SchedulerException {
		String schedulerName = this.getParameter("scheduler");
		String triggerName = this.getParameter("triggerName");
		String triggerGroup = this.getParameter("triggerGroup");
		String cmd = this.getParameter("cmd");
		
		return SchedulerManager.execTriggerCmd(schedulerName, triggerName, triggerGroup, cmd);
	}
	
	@RequestMapping(P.CONSOLE_SCHEDULING_GETTRIGGER)
	public @ResponseBody Object getTrigger() throws SchedulerException {
		String schedulerName = this.getParameter("scheduler");
		String triggerName = this.getParameter("triggerName");
		String triggerGroup = this.getParameter("triggerGroup");
		
		return SchedulerManager.getTriggerVO(schedulerName, triggerName, triggerGroup);
	}
	
	@RequestMapping(P.CONSOLE_SCHEDULING_ADDTRIGGER)
	public @ResponseBody Object addTrigger() throws SchedulerException {
		try {
			String schedulerName = this.getParameter("scheduler");
			TriggerVO triggerVO = this.getParameter(TriggerVO.class, false);
			
			SchedulerManager.addTrigger(schedulerName, triggerVO);
		} catch (Exception e) {
			logger.error(e.getMessage(), e);
			return e.getMessage();
		}
		
		return true;
	}
}