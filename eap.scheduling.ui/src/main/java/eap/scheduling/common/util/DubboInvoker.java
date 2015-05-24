package eap.scheduling.common.util;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;

import org.springframework.beans.factory.annotation.Autowired;

import com.alibaba.dubbo.config.ApplicationConfig;
import com.alibaba.dubbo.config.ReferenceConfig;
import com.alibaba.dubbo.config.RegistryConfig;
import com.alibaba.dubbo.rpc.service.GenericService;

import eap.util.BeanUtil;

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
public class DubboInvoker {
	
	public static final String CONFIG_SERVICE_CLASS = "interface";
	public static final String CONFIG_SERVICE_GROUP = "group";
	public static final String CONFIG_SERVICE_VERSION = "version";
	public static final String CONFIG_SERVICE_CLASS_IMPL = "interfaceImpl";
	public static final String CONFIG_METHOD = "method";
	public static final String CONFIG_MOCK = "mock";
	
	private Map<String, GenericService> services = new ConcurrentHashMap<String, GenericService>(new HashMap<String, GenericService>());
	private Lock serviceMoniter = new ReentrantLock();
	
	@Autowired
	public ApplicationConfig applicationConfig;
	@Autowired
	public List<RegistryConfig> registryConfigs;
	
	public Object invoke(Properties dubboCfg, Map<String, Object> msg) throws Exception {
		if ("true".equalsIgnoreCase(dubboCfg.getProperty(CONFIG_MOCK))) {
			dubboCfg.setProperty(CONFIG_SERVICE_CLASS_IMPL, dubboCfg.getProperty(CONFIG_SERVICE_CLASS) + "Mock");
		} else {
			dubboCfg.setProperty("generic", "true"); // 泛型接口
		}
		
		GenericService service = this.createService(dubboCfg);
		String method = dubboCfg.getProperty(CONFIG_METHOD);
		Object rspDTO = service.$invoke(method, new String[] {Map.class.getName()}, new Object[] {msg});
		
		return rspDTO;
	}
	
	private GenericService createService(Properties dubboCfg) {
		try {
			String serviceKey = this.getServiceKey(dubboCfg);
			GenericService service = services.get(serviceKey);
			try {
				serviceMoniter.lock();
				if (service == null) {
					
					ReferenceConfig reference = new ReferenceConfig();
					reference.setApplication(applicationConfig);
					reference.setRegistries(registryConfigs);
					BeanUtil.setProperty(reference, dubboCfg);
					
					service = (GenericService) reference.get();
					services.put(serviceKey, service);
				}
			} finally {
				serviceMoniter.unlock();
			}
			
			return service;
		} catch (Exception e) {
			throw new  IllegalArgumentException(e.getMessage(), e);
		}
	}
	private String getServiceKey(Properties dubboCfg) {
		return String.format("%s_%s_%s", 
			dubboCfg.getProperty(CONFIG_SERVICE_CLASS), 
			dubboCfg.getProperty(CONFIG_SERVICE_GROUP, ""),
			dubboCfg.getProperty(CONFIG_SERVICE_VERSION, "")
		);
	}
}