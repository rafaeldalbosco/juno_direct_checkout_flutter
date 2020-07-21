# DirectCheckout juno_direct_checkout

Esse plugin é a implementação para flutter dos projetos nativos:
[direct-checkout-android](https://github.com/tamojuno/direct-checkout-android)
[direct-checkout-ios](https://github.com/tamojuno/direct-checkout-ios)

SDK para criptografia e validação de dados de cartão de crédito para integração com a API de pagamentos da Juno/BoletoBancário.

Visando garantir a segurança das transações realizadas em nossa plataforma, a API da Juno adota uma política de criptografia dos dados de cartão de crédito de ponta-a-ponta.

Para mais informações acesse a página de integração:

[Integração via API](https://www.boletobancario.com/boletofacil/integration/integration.html) 

## Configurações do ambiente

Por questões de dependência do fornecedor das bibliotecas criptográficas para Android a SDK minima é ```21``` e IOS ```11```

### Android requer configuração adicional

Configure no arquivo AndroidManifest.xml o seu public token fornecido pela juno:
```xml
<manifest>

    <uses-permission android:name="android.permission.INTERNET"/>

    <application
           ...
           android:name=".MyApplication"
           ...>

        <meta-data
                android:name="br.com.juno.directcheckout.public_token"
                android:value="YOUR_PUBLIC_TOKEN"/>
        <meta-data
                android:name="br.com.juno.directcheckout.public_token_sandbox"
                android:value="YOUR_PUBLIC_TOKEN_SANDBOX"/>

            ...

    </application>

</manifest>
```



## Nota
Esse plugin foi testado utilizando Java no Android e Swift para IOS, caso tenha interesse em contribuir com o teste ou compatibilização para Objective C ou Kotlin (caso o mesmo não funcione adequadamente) estamos aberto para aceitar sugestões