# API Gatewayの作成
resource "aws_api_gateway_rest_api" "blog_api2" {
  name        = "blog_api2"
  description = "skill-up-engineering.comのblog"
}


resource "aws_api_gateway_resource" "res_1" {
  rest_api_id = aws_api_gateway_rest_api.blog_api2.id
  parent_id   = aws_api_gateway_rest_api.blog_api2.root_resource_id
  path_part   = "api"
}

resource "aws_api_gateway_resource" "res_2" {
  rest_api_id = aws_api_gateway_rest_api.blog_api2.id
  parent_id   = aws_api_gateway_rest_api.blog_api2.root_resource_id
  path_part   = "blogs"
}

resource "aws_api_gateway_resource" "res_3" {
  rest_api_id = aws_api_gateway_rest_api.blog_api2.id
  parent_id   = aws_api_gateway_rest_api.blog_api2.root_resource_id
  path_part   = "{post_no}"
}

resource "aws_api_gateway_resource" "res_4" {
  rest_api_id = aws_api_gateway_rest_api.blog_api2.id
  parent_id   = aws_api_gateway_rest_api.blog_api2.root_resource_id
  path_part   = "menus"
}



resource "aws_api_gateway_method" "method_1" {
  rest_api_id   = aws_api_gateway_rest_api.blog_api2.id
  resource_id   = aws_api_gateway_resource.res_2.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_method_response" "method_1_response" {
  rest_api_id = aws_api_gateway_rest_api.blog_api2.id
  resource_id = aws_api_gateway_resource.res_2.id
  http_method = aws_api_gateway_method.method_1.http_method
  status_code = "200"

  response_parameters = {
    "method.response.header.Content-Type" = true
  }

  response_models = {
    "application/json" = "Empty"
  }
}

resource "aws_api_gateway_integration" "method_1_integration" {
  rest_api_id             = aws_api_gateway_rest_api.blog_api2.id
  resource_id             = aws_api_gateway_resource.res_2.id
  http_method             = aws_api_gateway_method.method_1.http_method
  type                    = "AWS_PROXY"
  integration_http_method = "POST"
  uri                     = aws_lambda_function.blog_lambda.invoke_arn
}

resource "aws_api_gateway_integration_response" "method_1_integration_response" {
  rest_api_id = aws_api_gateway_rest_api.blog_api2.id
  resource_id = aws_api_gateway_resource.res_2.id
  http_method = aws_api_gateway_method.method_1.http_method
  status_code = "200"

  response_parameters = {
    "method.response.header.Content-Type" = "integration.response.header.Content-Type"
  }

  response_templates = {
    "application/json" = ""
  }

  depends_on = [
    aws_api_gateway_resource.res_2,
    aws_api_gateway_method.method_1,
    aws_api_gateway_method_response.method_1_response,
    aws_api_gateway_integration.method_1_integration
  ]
}

resource "aws_api_gateway_method" "method_2" {
  rest_api_id   = aws_api_gateway_rest_api.blog_api2.id
  resource_id   = aws_api_gateway_resource.res_2.id
  http_method   = "POST"
  authorization = "NONE"
}

resource "aws_api_gateway_method_response" "method_2_response" {
  rest_api_id = aws_api_gateway_rest_api.blog_api2.id
  resource_id = aws_api_gateway_resource.res_2.id
  http_method = aws_api_gateway_method.method_2.http_method
  status_code = "200"

  response_parameters = {
    "method.response.header.Content-Type" = true
  }

  response_models = {
    "application/json" = "Empty"
  }
}

resource "aws_api_gateway_integration" "method_2_integration" {
  rest_api_id             = aws_api_gateway_rest_api.blog_api2.id
  resource_id             = aws_api_gateway_resource.res_2.id
  http_method             = aws_api_gateway_method.method_2.http_method
  type                    = "AWS_PROXY"
  integration_http_method = "POST"
  uri                     = aws_lambda_function.blog_lambda.invoke_arn
}

resource "aws_api_gateway_integration_response" "method_2_integration_response" {
  rest_api_id = aws_api_gateway_rest_api.blog_api2.id
  resource_id = aws_api_gateway_resource.res_2.id
  http_method = aws_api_gateway_method.method_2.http_method
  status_code = "200"

  response_parameters = {
    "method.response.header.Content-Type" = "integration.response.header.Content-Type"
  }

  response_templates = {
    "application/json" = ""
  }

  depends_on = [
    aws_api_gateway_resource.res_2,
    aws_api_gateway_method.method_2,
    aws_api_gateway_method_response.method_2_response,
    aws_api_gateway_integration.method_2_integration
  ]
}

resource "aws_api_gateway_method" "method_3" {
  rest_api_id   = aws_api_gateway_rest_api.blog_api2.id
  resource_id   = aws_api_gateway_resource.res_3.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_method_response" "method_3_response" {
  rest_api_id = aws_api_gateway_rest_api.blog_api2.id
  resource_id = aws_api_gateway_resource.res_3.id
  http_method = aws_api_gateway_method.method_3.http_method
  status_code = "200"

  response_parameters = {
    "method.response.header.Content-Type" = true
  }

  response_models = {
    "application/json" = "Empty"
  }
}

resource "aws_api_gateway_integration" "method_3_integration" {
  rest_api_id             = aws_api_gateway_rest_api.blog_api2.id
  resource_id             = aws_api_gateway_resource.res_3.id
  http_method             = aws_api_gateway_method.method_3.http_method
  type                    = "AWS_PROXY"
  integration_http_method = "POST"
  uri                     = aws_lambda_function.blog_lambda.invoke_arn
}

resource "aws_api_gateway_integration_response" "method_3_integration_response" {
  rest_api_id = aws_api_gateway_rest_api.blog_api2.id
  resource_id = aws_api_gateway_resource.res_3.id
  http_method = aws_api_gateway_method.method_3.http_method
  status_code = "200"

  response_parameters = {
    "method.response.header.Content-Type" = "integration.response.header.Content-Type"
  }

  response_templates = {
    "application/json" = ""
  }

  depends_on = [
    aws_api_gateway_resource.res_3,
    aws_api_gateway_method.method_3,
    aws_api_gateway_method_response.method_3_response,
    aws_api_gateway_integration.method_3_integration
  ]
}

resource "aws_api_gateway_method" "method_4" {
  rest_api_id   = aws_api_gateway_rest_api.blog_api2.id
  resource_id   = aws_api_gateway_resource.res_3.id
  http_method   = "PUT"
  authorization = "NONE"
}

resource "aws_api_gateway_method_response" "method_4_response" {
  rest_api_id = aws_api_gateway_rest_api.blog_api2.id
  resource_id = aws_api_gateway_resource.res_3.id
  http_method = aws_api_gateway_method.method_4.http_method
  status_code = "200"

  response_parameters = {
    "method.response.header.Content-Type" = true
  }

  response_models = {
    "application/json" = "Empty"
  }
}

resource "aws_api_gateway_integration" "method_4_integration" {
  rest_api_id             = aws_api_gateway_rest_api.blog_api2.id
  resource_id             = aws_api_gateway_resource.res_3.id
  http_method             = aws_api_gateway_method.method_4.http_method
  type                    = "AWS_PROXY"
  integration_http_method = "POST"
  uri                     = aws_lambda_function.blog_lambda.invoke_arn
}

resource "aws_api_gateway_integration_response" "method_4_integration_response" {
  rest_api_id = aws_api_gateway_rest_api.blog_api2.id
  resource_id = aws_api_gateway_resource.res_3.id
  http_method = aws_api_gateway_method.method_4.http_method
  status_code = "200"

  response_parameters = {
    "method.response.header.Content-Type" = "integration.response.header.Content-Type"
  }

  response_templates = {
    "application/json" = ""
  }

  depends_on = [
    aws_api_gateway_resource.res_3,
    aws_api_gateway_method.method_4,
    aws_api_gateway_method_response.method_4_response,
    aws_api_gateway_integration.method_4_integration
  ]
}

resource "aws_api_gateway_method" "method_5" {
  rest_api_id   = aws_api_gateway_rest_api.blog_api2.id
  resource_id   = aws_api_gateway_resource.res_4.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_method_response" "method_5_response" {
  rest_api_id = aws_api_gateway_rest_api.blog_api2.id
  resource_id = aws_api_gateway_resource.res_4.id
  http_method = aws_api_gateway_method.method_5.http_method
  status_code = "200"

  response_parameters = {
    "method.response.header.Content-Type" = true
  }

  response_models = {
    "application/json" = "Empty"
  }
}

resource "aws_api_gateway_integration" "method_5_integration" {
  rest_api_id             = aws_api_gateway_rest_api.blog_api2.id
  resource_id             = aws_api_gateway_resource.res_4.id
  http_method             = aws_api_gateway_method.method_5.http_method
  type                    = "AWS_PROXY"
  integration_http_method = "POST"
  uri                     = aws_lambda_function.blog_lambda.invoke_arn
}

resource "aws_api_gateway_integration_response" "method_5_integration_response" {
  rest_api_id = aws_api_gateway_rest_api.blog_api2.id
  resource_id = aws_api_gateway_resource.res_4.id
  http_method = aws_api_gateway_method.method_5.http_method
  status_code = "200"

  response_parameters = {
    "method.response.header.Content-Type" = "integration.response.header.Content-Type"
  }

  response_templates = {
    "application/json" = ""
  }

  depends_on = [
    aws_api_gateway_resource.res_4,
    aws_api_gateway_method.method_5,
    aws_api_gateway_method_response.method_5_response,
    aws_api_gateway_integration.method_5_integration
  ]
}
