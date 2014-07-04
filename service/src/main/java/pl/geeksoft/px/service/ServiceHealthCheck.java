package pl.geeksoft.px.service;

import com.codahale.metrics.health.HealthCheck;

public class ServiceHealthCheck extends HealthCheck {

	@Override
	protected Result check() throws Exception {
		return Result.healthy();
	}
}
