package pl.geeksoft.px.service;

import com.wordnik.swagger.config.ScannerFactory;
import com.wordnik.swagger.jaxrs.config.DefaultJaxrsScanner;
import com.wordnik.swagger.jaxrs.listing.ApiDeclarationProvider;
import com.wordnik.swagger.jaxrs.listing.ApiListingResourceJSON;
import com.wordnik.swagger.jaxrs.listing.ResourceListingProvider;
import com.wordnik.swagger.jaxrs.reader.DefaultJaxrsApiReader;
import com.wordnik.swagger.reader.ClassReaders;
import io.dropwizard.Application;
import io.dropwizard.setup.Bootstrap;
import io.dropwizard.setup.Environment;
import org.eclipse.jetty.servlets.CrossOriginFilter;
import pl.geeksoft.px.service.resources.UserResource;

import java.util.EnumSet;

import static javax.servlet.DispatcherType.REQUEST;

public class ServiceRunner extends Application<ServiceConfig> {

	public static void main(String[] args) throws Exception {
		new ServiceRunner().run(args);
	}

	@Override
	public void initialize(Bootstrap<ServiceConfig> bootstrap) {
		// do nothing
	}

	@Override
	public void run(ServiceConfig configuration, Environment environment) throws Exception {
		registerApiDoc(environment);
		registerService(configuration, environment);
	}

	private void registerApiDoc(Environment environment) {
		environment.servlets().addFilter("CORS", CrossOriginFilter.class).addMappingForUrlPatterns(EnumSet.of(REQUEST), true, "/*");
		environment.jersey().register(new ApiListingResourceJSON());
		environment.jersey().register(new ApiDeclarationProvider());
		environment.jersey().register(new ResourceListingProvider());
		ScannerFactory.setScanner(new DefaultJaxrsScanner());
		ClassReaders.setReader(new DefaultJaxrsApiReader());
	}

	private void registerService(ServiceConfig configuration, Environment environment) {
		environment.jersey().register(new UserResource(configuration.getVoucherLength()));
		environment.healthChecks().register("service", new ServiceHealthCheck());
	}
}
