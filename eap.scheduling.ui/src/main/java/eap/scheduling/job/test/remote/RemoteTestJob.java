package eap.scheduling.job.test.remote;

import java.util.Map;

public interface RemoteTestJob {
	public String echo(Map<String, Object> params);
}
