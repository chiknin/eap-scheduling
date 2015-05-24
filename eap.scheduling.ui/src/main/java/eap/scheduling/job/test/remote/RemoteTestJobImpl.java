package eap.scheduling.job.test.remote;

import java.util.Map;

public class RemoteTestJobImpl implements RemoteTestJob {
	public String echo(Map<String, Object> params) {
		System.out.println("RemoteTestJobImpl.echo > " + params);
		return "OK";
	}
}