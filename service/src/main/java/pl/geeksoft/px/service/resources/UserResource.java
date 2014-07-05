package pl.geeksoft.px.service.resources;

import com.codahale.metrics.annotation.Timed;
import com.wordnik.swagger.annotations.Api;
import com.wordnik.swagger.annotations.ApiOperation;
import com.wordnik.swagger.annotations.ApiParam;
import pl.geeksoft.px.model.RegistrationResult;

import javax.ws.rs.FormParam;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;

import static java.util.UUID.randomUUID;

@Path("/user")
@Produces(MediaType.APPLICATION_JSON)
@Api(value = "/user", description = "Operations with user accounts")
public class UserResource {

    private final int voucherLength;

    public UserResource(int voucherLength) {
        this.voucherLength = voucherLength;
    }

    @POST
    @Timed
    @Path("/register")
    @ApiOperation(value = "Registers user account", response = String.class)
    public RegistrationResult register(
            @FormParam("email") @ApiParam(value = "User email", required = true) String email,
            @FormParam("password") @ApiParam(value = "User password", required = true) String password) {
        RegistrationResult registrationResult = new RegistrationResult(email);
        registrationResult.setVoucher(randomUUID().toString().substring(2, 2 + voucherLength));
        return registrationResult;
    }

}
