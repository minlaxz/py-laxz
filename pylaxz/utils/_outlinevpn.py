import requests
requests.urllib3.disable_warnings()


class OutlineVPN:
    """
    Outline VPN 

    Options
    -------
    0. -h, --help (help for this options)
    1. -r (remove existing user with key)
    2. get (list existing users and keys)
    3. -a (append new user with key)
    """

    def __init__(self) -> object:
        self.API_URL = input('API_URL? : ')
        self.res_list = requests.get(self.API_URL+'/access-keys', verify=False)
        
        if self.res_list:
            print(f'URL is valid and return {self.res_list.status_code}')
        else:
            print(f'An error occurred and return {self.res_list.status_code}')

    def get_lists(self) -> list:
        return self.res_list.json()['accessKeys']

    def get_metrics(self) -> list:
        res = requests.get(self.API_URL+'/metrics/transfer', verify=False)
        return res.json()['bytesTransferredByUserId']

    def post(self) -> bool:
        user_name = input('Enter new username: ')

    def delete(self) -> bool:
        user_id = input('Enter User ID: ')

    def put(self) -> bool:
        pass
