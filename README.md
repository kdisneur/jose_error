# Jose Error

When we bumped from `jose` `1.8.4` to `1.9.0` some of our tests started failing.

Here a sample application with a reproduction test case.

If we activate the `< 1.9.0` version on the `mix.exs`, the test pass.

```
mix test
.

Finished in 0.05 seconds
1 test, 0 failures

Randomized with seed 754234
```

If we activate the `~> 1.9` version on the `mix.exs`, the test fail.

```
mix test


  1) test weird error (JoseErrorTest)
     test/jose_error_test.exs:45
     ** (ErlangError) Erlang error: {:crypt_unsupported, [[rsa_padding: :rsa_pkcs1_oaep_padding, rsa_oaep_md: :sha256]]}
     code: |> JOSE.JWK.block_encrypt(%{"alg" => "RSA-OAEP-256", "enc" => "A128GCM"}, jwk)
     stacktrace:
       (jose) src/jose_jwa_unsupported.erl:49: :jose_jwa_unsupported.encrypt_public/3
       (jose) src/jose_jwe_alg_rsa.erl:73: :jose_jwe_alg_rsa.key_encrypt/3
       (jose) src/jose_jwe.erl:296: :jose_jwe.key_encrypt/3
       (jose) src/jose_jwe.erl:204: :jose_jwe.block_encrypt/5
       test/jose_error_test.exs:51: (test)



Finished in 0.04 seconds
1 test, 1 failure

Randomized with seed 304751
```
