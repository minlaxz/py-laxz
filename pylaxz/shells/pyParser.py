#! /usr/bin/python3
import sys
import json
from pylaxz import printf


def overview_metrics():
    printf(json.loads(sys.argv[1:][0]), _int=1)


def detail_information(*arg):
    metrics_data = json.loads(sys.argv[1:][0])

    # parse single {compact} json string
    access_lists = sys.argv[1:][1][1:-1]

    # manipulate for making string to dictionaries
    access_lists = ['{'+i+'}' for i in access_lists.split('},{')]

    # '[{{},{},{},{}}]' remove '{'....'}'
    access_lists[0] = access_lists[0][1:]
    access_lists[-1] = access_lists[-1][:-1]

    # [{},{},{}]
    access_key_dicts = [json.loads(i) for i in access_lists]

    # printf(access_key_dicts)
    id_or_name = arg[0] if len(arg) > 0 else None
    if id_or_name is not None:
        found_flag = False
        var_id = None
        for i in access_key_dicts:
            for k, v in i.items():
                if k == 'id' or k == 'name':
                    if v == id_or_name:
                        if 'dataLimit' in i:
                            limit = i['dataLimit']['bytes'] / (1024**3)
                            printf("DataLimit Found. : {0:.2f} MB".format(
                                limit), _int=1)
                        else:
                            limit = 0
                        found_flag = True
                        var_id = id_or_name if k == 'id' else i['id']
                        printf(json.dumps(i, indent=4, sort_keys=False), _int=1)
                        try:
                            metric_bytes = metrics_data[var_id]/(1024**3)
                            printf("Usage : {0:.2f} MB".format(
                                metric_bytes), _int=1)
                            if limit != 0:
                                print('Key is DISABLED' if metric_bytes >
                                      limit else 'Warning')
                        except KeyError:
                            printf(f'This ID {var_id} has no usage.', _int=1)
        if not found_flag:
            printf(f'ID : {id_or_name} is Deleted or Not Found !', _int=1)
    else:
        for i in access_key_dicts:
            printf(json.dumps(i, indent=4, sort_keys=False), _int=1)


def oneDetails(userID, userName, userPassword, dataTransferred, ss, dataLimit=None):
    printf(f'ID: {userID}, Name: {userName}, Password: {userPassword}, DataTransferred: {dataTransferred}GB\nAccessURL: {ss}', _int=1)


def details(*arg):

    users = arg[0]
    metrics = arg[1]

    for user in users:
        user['dataTransferred'] = metrics[user['id']] / \
            (1024**3) if user['id'] in metrics.keys() else None

    if len(arg) == 3:
        for user in users:
            printf(
                f'{user["id"]}, {user["name"]}, {user["dataTransferred"]}GB', _int=1)
        try:
            userID = input("Enter User ID : ")
            userID = int(userID)
            for user in users:
                for k, v in user.items():
                    if k == 'id' and v == str(userID):
                        oneDetails(user['id'], user['name'],
                                   user['password'], user['dataTransferred'],
                                   user['accessUrl'])
        except ValueError:
            print('Only ID.')
        except KeyboardInterrupt:
            print('Exit.')
    else:
        for user in users:
            if user['dataTransferred']:
                if 'dataLimit' in user.keys():
                    printf(
                        f'{user} Found DataLimit:{user["dataLimit"]["bytes"]/(1024**3)}GB', _int=1, _err=1)
                else:
                    printf(user, _int=1)
            else:
                printf('No Usage. {}'.format(user), _int=1, _err=1)


if __name__ == "__main__":
    if len(sys.argv) == 2:
        overview_metrics()
    elif len(sys.argv) == 3:
        detail_information()
    elif len(sys.argv) == 4:
        detail_information(sys.argv[3])
    else:
        printf('Error few many args : {}'.format(
            len(sys.argv)), _err=True, _int=1)
