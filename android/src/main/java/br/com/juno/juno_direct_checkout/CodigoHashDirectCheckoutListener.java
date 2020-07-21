package br.com.juno.juno_direct_checkout;

import br.com.juno.directcheckout.model.DirectCheckoutException;
import br.com.juno.directcheckout.model.DirectCheckoutListener;

import io.flutter.plugin.common.MethodChannel.Result;

public class CodigoHashDirectCheckoutListener implements DirectCheckoutListener<String> {

    private final Result result;

    public CodigoHashDirectCheckoutListener(Result result) {
        this.result = result;
    }

    @Override
    public void onSuccess(String cardHash) {
        /* Sucesso - A variável cardHash conterá o hash do cartão de crédito */
        result.success(cardHash);
    }
    @Override
    public void onFailure(DirectCheckoutException exception) {
        /* Erro - A variável exception conterá o erro ocorrido ao obter o hash */
        result.error("getCardHashError", exception.getMessage(), null);
    }
}
