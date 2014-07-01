package pl.geeksoft.px.service;

import com.fasterxml.jackson.annotation.JsonProperty;
import io.dropwizard.Configuration;

import javax.validation.constraints.Min;

public class ServiceConfig extends Configuration {

	@Min(8)
	@JsonProperty
	private int voucherLength;

	public int getVoucherLength() {
		return voucherLength;
	}
}
