defmodule JoseErrorTest do
  use ExUnit.Case

  @public_key """
  -----BEGIN RSA PUBLIC KEY-----
  MIIBCgKCAQEAySRnT7kUj7wC/64l+Ncm266YrtPn4Qdt+at4iFTUDosYOoy1Otec
  Li//HVv/CqSDG8wZ0NIwEjxaB0ZEckPMl9BDGjtjsaiYfq4hVhJ47m+0yKNfaPDH
  uWxV3bEx+7E+ZlPYMPvbQ2kA5KvPyjAGI9YSfxaf+kcnNjxv+3aY49vqjPnGahY4
  vuhM7y+cRUlrWHxd5DgdyurYuZw8xOT+KmKe/MsstbDtzY+16nibVvGz4jeJYiZQ
  arB2q1Vd/FpN+KSrdcwr9GvMsvhdf4wk3E++/c5p6eMS0onn0t3Cbl4oGtAssFXg
  EszGZGw1UAHJiiQSUsrMKcPwE0Eec5n+gwIDAQAB
  -----END RSA PUBLIC KEY-----
  """

  @private_key """
  -----BEGIN RSA PRIVATE KEY-----
  MIIEowIBAAKCAQEAySRnT7kUj7wC/64l+Ncm266YrtPn4Qdt+at4iFTUDosYOoy1
  OtecLi//HVv/CqSDG8wZ0NIwEjxaB0ZEckPMl9BDGjtjsaiYfq4hVhJ47m+0yKNf
  aPDHuWxV3bEx+7E+ZlPYMPvbQ2kA5KvPyjAGI9YSfxaf+kcnNjxv+3aY49vqjPnG
  ahY4vuhM7y+cRUlrWHxd5DgdyurYuZw8xOT+KmKe/MsstbDtzY+16nibVvGz4jeJ
  YiZQarB2q1Vd/FpN+KSrdcwr9GvMsvhdf4wk3E++/c5p6eMS0onn0t3Cbl4oGtAs
  sFXgEszGZGw1UAHJiiQSUsrMKcPwE0Eec5n+gwIDAQABAoIBABZAUrV9Egs8j1Bd
  oZG/q2rOC9H7W0GHouDl2TWrvLHHLWz8t+fEhmCNqrlCvhodTOu8TnbNacf6qTL4
  0QWa/n0k6udx/nte3U/WT5XIAVzPOr6fZCSlzlJy66TUv2TKnM6RI+93TTBN421o
  nFoPqf445l7sz9HOIUZctT6qRguezC4WgyzH86ZtsXC1gvUtMaU2SrHZLapnWMt9
  oy1wBKIEq7Glk5iOjKGw75YCoRxSD4RkQIjG+QG7F3MlB9p/DQlrFsfVoz1ww2ba
  hzi2jJq+hj2OiNu/j5ZABZ6VLkgivfW8atz8zTeyRwzqLPFPy1n2bWMJ1yRi/PQp
  sEU0/YECgYEA8Ni5J0R0MxtW39u1oFDcmPOdwG2E0moXP7P20fpEd5R9ycp4bMhY
  uQ9mL7V1vYuqYICl2FROiDon+LruxH51bYUU72BP09wTOViw5cKfNXL++/7ptUUl
  +yCagQKXXR0a4A2bJiyNBjXDpcZdOHD93YnP9rBHpWNSIPOAPEf2LmECgYEA1cwr
  G78xb/ry9Tf0K3VNb+83vd+lrotgBRzdd2UIQ9kCFHYlFbn/iPwcoE2mdHcOsZK6
  sIX8cRbk9p8ZclBh5FGoujcWHjf75DoUH7NmWzQZJgDF1GmvWFHVjx3b3obT6MR0
  Wd5C8mv9YMT/dM2d2gBoL+v8MF8fNMb154GKb2MCgYA7XJ9eH1AonI9wA34jsmp8
  xGbYW+YF2qI6UEgAfxfLBW1vhBjkbwj3K+V60tXfTwJCYNL/m9/zUaoycxiQk76r
  rMZ5LZrfU/nlA4guSSbmjJ5uS+kchZuT5vhN3e6iw56xJIleAlML+cpsHJUzaR4Z
  MXNxkQdHq1A90OaFdRMnYQKBgQC5Ahyrvh+Bz58/JFRe5vtDybZq0IYHLQTCZ+Ad
  2Yf1bmymWDZvPq0qVUBQV+GbFwvYDikPaGKzWiR4ZeUXTwfnE+L2gYTaUYfgT4Hq
  jMweUE8S28hVr77UprwvRJ9nSTVHT/l/ax5zuY9hlheZc/UNGR0Pmx54nVfby/Av
  jaHGEQKBgDjJVsUEhzfet4asizelQfBUuZIzJ6tgkTD8tnCiteNlq+WrUot4aEE2
  5GcVHl4Cx9dwJ/JaqFtFS62R5yqLGo41Pzrh18yGJb30o8rjL1cwb0dQNl4GFHEY
  yZTRsjD/g5kXQU8Z+2TGRtF/syPYnUtnn7c3xxEeXWAezoYcldtW
  -----END RSA PRIVATE KEY-----
  """

  test "weird error" do
    jwk = JOSE.JWK.from_pem(@public_key)

    assert {_, token} =
             %{id: "42"}
             |> Poison.encode!()
             |> JOSE.JWK.block_encrypt(%{"alg" => "RSA-OAEP-256", "enc" => "A128GCM"}, jwk)
             |> JOSE.JWE.compact()

    assert {token, _} = JOSE.JWK.block_decrypt(token, JOSE.JWK.from_pem(@private_key))
    assert ~S({"id":"42"}) == token
  end
end
