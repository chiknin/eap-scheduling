package eap.scheduling.job;

import java.util.HashMap;
import java.util.Map;
import java.util.Properties;

import org.quartz.JobDataMap;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.scheduling.quartz.QuartzJobBean;

import eap.scheduling.common.util.DubboInvoker;
import eap.util.EDcodeUtil;
import eap.util.PropertiesUtil;
import eap.util.objectfactory.ObjectFactory;

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
public class RemoteJob extends QuartzJobBean {
	
	private static final Logger LOG = LoggerFactory.getLogger(RemoteJob.class);
	
	protected void executeInternal(JobExecutionContext context) throws JobExecutionException {
		JobDataMap jobDataMap = context.getMergedJobDataMap();
		Map<String, Object> wrappedMap = jobDataMap.getWrappedMap();
		
		Map<String, Object> jobContext = new HashMap<String, Object>();
		jobContext.put("fireInstanceId", context.getFireInstanceId());
		jobContext.put("scheduledFireTime", context.getScheduledFireTime());
		jobContext.put("fireTime", context.getFireTime());
		jobContext.put("previousFireTime", context.getPreviousFireTime());
		jobContext.put("nextFireTime", context.getNextFireTime());
		jobContext.put("refireCount", context.getRefireCount());
		jobContext.put("jobDataMap", wrappedMap); // filtered startWith "_"
		
		Properties dubboCfg = PropertiesUtil.filterForPrefix(PropertiesUtil.from(wrappedMap), "_dubbo.");
		DubboInvoker dubboInvoker = ObjectFactory.getObject("spring dubboInvoker", DubboInvoker.class);
		
		try {
			String requestId = EDcodeUtil.uuid();
			jobContext.put("requestId", requestId);
			
			long startTime = System.currentTimeMillis();
			LOG.info("start job: {} {}", requestId, jobContext);
			
			Object rspDTO = dubboInvoker.invoke(dubboCfg, jobContext);
			
			long endTime = System.currentTimeMillis();
			LOG.info("finish job: {} {}ms {}", requestId, (endTime - startTime), rspDTO);
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
		}
	}
}