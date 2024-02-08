const amplifyconfig = '''{
    "UserAgent": "aws-amplify-cli/2.0",
    "Version": "1.0",
    "api": {
        "plugins": {
            "awsAPIPlugin": {
                "makulay": {
                    "endpointType": "GraphQL",
                    "endpoint": "https://gecwqjzi3zghbluzi7k7qbdjsq.appsync-api.ap-southeast-1.amazonaws.com/graphql",
                    "region": "ap-southeast-1",
                    "authorizationType": "API_KEY",
                    "apiKey": "da2-vshfb42rbjaepcznb3c4l5qrfe"
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
                "AppSync": {
                    "Default": {
                        "ApiUrl": "https://gecwqjzi3zghbluzi7k7qbdjsq.appsync-api.ap-southeast-1.amazonaws.com/graphql",
                        "Region": "ap-southeast-1",
                        "AuthMode": "API_KEY",
                        "ApiKey": "da2-vshfb42rbjaepcznb3c4l5qrfe",
                        "ClientDatabasePrefix": "makulay_API_KEY"
                    },
                    "makulay_AWS_IAM": {
                        "ApiUrl": "https://gecwqjzi3zghbluzi7k7qbdjsq.appsync-api.ap-southeast-1.amazonaws.com/graphql",
                        "Region": "ap-southeast-1",
                        "AuthMode": "AWS_IAM",
                        "ClientDatabasePrefix": "makulay_AWS_IAM"
                    }
                },
                "CredentialsProvider": {
                    "CognitoIdentity": {
                        "Default": {
                            "PoolId": "ap-southeast-1:4d29215b-82c8-41d3-8260-2dfcbde52b4d",
                            "Region": "ap-southeast-1"
                        }
                    }
                },
                "CognitoUserPool": {
                    "Default": {
                        "PoolId": "ap-southeast-1_FIhd1BRhs",
                        "AppClientId": "27mok2agpum3avj6stri493259",
                        "Region": "ap-southeast-1"
                    }
                },
                "Auth": {
                    "Default": {
                        "authenticationFlowType": "USER_SRP_AUTH",
                        "mfaConfiguration": "OFF",
                        "mfaTypes": [
                            "SMS"
                        ],
                        "passwordProtectionSettings": {
                            "passwordPolicyMinLength": 8,
                            "passwordPolicyCharacters": []
                        },
                        "signupAttributes": [
                            "EMAIL"
                        ],
                        "socialProviders": [],
                        "usernameAttributes": [
                            "EMAIL",
                            "PHONE_NUMBER"
                        ],
                        "verificationMechanisms": [
                            "EMAIL"
                        ]
                    }
                },
                "S3TransferUtility": {
                    "Default": {
                        "Bucket": "makulay8bf74d2dc76d4f068d2db770d437b058210358-dev",
                        "Region": "ap-southeast-1"
                    }
                }
            }
        }
    },
    "storage": {
        "plugins": {
            "awsS3StoragePlugin": {
                "bucket": "makulay8bf74d2dc76d4f068d2db770d437b058210358-dev",
                "region": "ap-southeast-1",
                "defaultAccessLevel": "guest"
            }
        }
    }
}''';
