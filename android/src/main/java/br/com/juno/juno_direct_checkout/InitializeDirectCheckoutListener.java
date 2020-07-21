package br.com.juno.juno_direct_checkout;

import br.com.juno.directcheckout.model.DirectCheckoutException;
import br.com.juno.directcheckout.model.DirectCheckoutListener;

import io.flutter.plugin.common.MethodChannel.Result;

public class InitializeDirectCheckoutListener implements DirectCheckoutListener<Boolean> {

    private final Result result;

    public InitializeDirectCheckoutListener(Result result) {
        this.result = result;
    }

    @Override
    public void onSuccess(Boolean response) {
        result.success(response.toString());
    }
    @Override
    public void onFailure(DirectCheckoutException exception) {
        result.error("initializeError", exception.getMessage(), null);
    }
}
