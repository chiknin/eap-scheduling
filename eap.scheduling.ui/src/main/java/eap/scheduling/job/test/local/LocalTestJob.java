package eap.scheduling.job.test.local;

import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.scheduling.quartz.QuartzJobBean;

//@DisallowConcurrentExecution
//@PersistJobDataAfterExecution
public class LocalTestJob extends QuartzJobBean {
	
	private static final Logger LOG = LoggerFactory.getLogger(LocalTestJob.class);
	
	protected void executeInternal(JobExecutionContext context) throws JobExecutionException {
		try {
			Thread.sleep(15000);
		} catch (InterruptedException e) {
			e.printStackTrace();
		}
		
		LOG.info("{}", context);
//		System.out.println(DateUtil.currDateFull() + "    " + Thread.currentThread() + " " + context);
//		LoggerFactory.getLogger(RemoteJob.class).info("{}", context.getResult()); // null
//		LoggerFactory.getLogger(RemoteJob.class).info("{}", context.getCalendar()); // null
//		LoggerFactory.getLogger(RemoteJob.class).info("{}", context.getFireInstanceId()); // NON_CLUSTERED1420120511510
//		LoggerFactory.getLogger(RemoteJob.class).info("{}", DateUtil.format(context.getFireTime(), "yyyy-MM-dd HH:mm:ss.SSS")); // 2015-01-01 21:56:45.059
//		LoggerFactory.getLogger(RemoteJob.class).info("{}", context.getJobDetail()); // JobDetail 'DEFAULT.testjob':  jobClass: 'eap.scheduling.job.TestJob concurrentExectionDisallowed: false persistJobDataAfterExecution: false isDurable: true requestsRecovers: true
//		LoggerFactory.getLogger(RemoteJob.class).info("{}", context.getJobInstance()); // eap.scheduling.job.TestJob@3e2b8fbb
//		LoggerFactory.getLogger(RemoteJob.class).info("{}", context.getMergedJobDataMap()); // org.quartz.JobDataMap@0
//		LoggerFactory.getLogger(RemoteJob.class).info("{}", context.getNextFireTime()); // Thu Jan 01 21:56:50 CST 2015
//		LoggerFactory.getLogger(RemoteJob.class).info("{}", context.getPreviousFireTime()); // Thu Jan 01 21:56:40 CST 2015
//		LoggerFactory.getLogger(RemoteJob.class).info("{}", context.getRefireCount()); // 0
//		LoggerFactory.getLogger(RemoteJob.class).info("{}", DateUtil.format(context.getScheduledFireTime(), "yyyy-MM-dd HH:mm:ss.SSS")); // 2015-01-01 21:56:45.000
	}
}