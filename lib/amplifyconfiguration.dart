const amplifyconfig = '''{
    "UserAgent": "aws-amplify-cli/2.0",
    "Version": "1.0",
    "api": {
        "plugins": {
            "awsAPIPlugin": {
                "agilay": {
                    "endpointType": "GraphQL",
                    "endpoint": "https://csqqottnozhljjtemfzm3artuu.appsync-api.us-east-1.amazonaws.com/graphql",
                    "region": "us-east-1",
                    "authorizationType": "API_KEY",
                    "apiKey": "da2-4zhexwhgzveqthu3lcwehroj7e"
                }
            }
        }
    },
    "auth": {
        "plugins": {
            "awsCognitoAuthPlugin": {
                "UserAgent": "aws-amplify-cli/0.1.0",
                "Version": "0.1.0",
                "IdentityManager": {
                    "Default": {}
                },
                "CredentialsProvider": {
                    "CognitoIdentity": {
                        "Default": {
                            "PoolId": "us-east-1:052bbceb-ee4d-4227-8fda-77662c8ad97f",
                            "Region": "us-east-1"
                        }
                    }
                },
                "CognitoUserPool": {
                    "Default": {
                        "PoolId": "us-east-1_4rpgzvuS1",
                        "AppClientId": "5vr8sva116isud6fbenqbkmsp8",
                        "Region": "us-east-1"
                    }
                },
                "Auth": {
                    "Default": {
                        "authenticationFlowType": "USER_SRP_AUTH",
                        "socialProviders": [],
                        "usernameAttributes": [
                            "EMAIL",
                            "PHONE_NUMBER"
                        ],
                        "signupAttributes": [
                            "EMAIL"
                        ],
                        "passwordProtectionSettings": {
                            "passwordPolicyMinLength": 8,
                            "passwordPolicyCharacters": []
                        },
                        "mfaConfiguration": "OFF",
                        "mfaTypes": [
                            "SMS"
                        ],
                        "verificationMechanisms": [
                            "EMAIL"
                        ]
                    }
                },
                "S3TransferUtility": {
                    "Default": {
                        "Bucket": "agilay51cb75ea91264f98aea831d548621e0940209-dev",
                        "Region": "us-east-1"
                    }
                },
                "AppSync": {
                    "Default": {
                        "ApiUrl": "https://csqqottnozhljjtemfzm3artuu.appsync-api.us-east-1.amazonaws.com/graphql",
                        "Region": "us-east-1",
                        "AuthMode": "API_KEY",
                        "ApiKey": "da2-4zhexwhgzveqthu3lcwehroj7e",
                        "ClientDatabasePrefix": "agilay_API_KEY"
                    },
                    "agilay_AMAZON_COGNITO_USER_POOLS": {
                        "ApiUrl": "https://csqqottnozhljjtemfzm3artuu.appsync-api.us-east-1.amazonaws.com/graphql",
                        "Region": "us-east-1",
                        "AuthMode": "AMAZON_COGNITO_USER_POOLS",
                        "ClientDatabasePrefix": "agilay_AMAZON_COGNITO_USER_POOLS"
                    }
                }
            }
        }
    },
    "storage": {
        "plugins": {
            "awsS3StoragePlugin": {
                "bucket": "agilay51cb75ea91264f98aea831d548621e0940209-dev",
                "region": "us-east-1",
                "defaultAccessLevel": "guest"
            }
        }
    }
}''';
