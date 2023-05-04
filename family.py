import uuid


def get_andersen_family_item():
    andersen_item = {
    'id': 'Andersen_' + str(uuid.uuid4()),
    'lastName': 'Andersen',
    'district': 'WA5',
    'parents': [
        {
            'familyName': None,
            'firstName': 'Thomas',
            'description': 'Å å Ø ø Æ æ 葉繼問 イップ・マン 엽문'
        },
        {
            'familyName': None,
            'firstName': 'Mary Kay',
            'description': 'Å å Ø ø Æ æ 葉繼問 イップ・マン 엽문'
        }
    ],
    'children': None,
    'address': {
        'state': 'WA',
        'county': 'King',
        'city': 'Seattle'
    },
    'registered': True
}
    return andersen_item

def get_wakefield_family_item():
    wakefield_item = {
        'id': 'Wakefield_' + str(uuid.uuid4()),
        'lastName': 'Wakefield',
        'district': 'NY23',
        'parents': [
            {
                'familyName': 'Wakefield',
                'firstName': 'Robin',
                'description': 'Å å Ø ø Æ æ 葉繼問 イップ・マン 엽문'
            },
            {
                'familyName': 'Miller',
                'firstName': 'Ripley',
                'description': 'Å å Ø ø Æ æ 葉繼問 イップ・マン 엽문'
            }
        ],
        'children': [
            {
                'familyName': 'Merriam',
                'firstName': 'Jesse',
                'gender': None,
                'grade': 8,
                'pets': [
                    {
                        'givenName': 'Goofy'
                    },
                    {
                        'givenName': 'Shadow'
                    }
                ],
                'description': 'Å å Ø ø Æ æ 葉繼問 イップ・マン 엽문'
            },
            {
                'familyName': 'Miller',
                'firstName': 'Lisa',
                'gender': 'female',
                'grade': 1,
                'pets': None,
                'description': 'Å å Ø ø Æ æ 葉繼問 イップ・マン 엽문'
            }
        ],
        'address': {
            'state': 'NY',
            'county': 'Manhattan',
            'city': 'NY'
        },
        'registered': True
    }
    return wakefield_item

def get_smith_family_item():
    smith_item = {
    'id': 'Johnson_' + str(uuid.uuid4()),
    'lastName': 'Johnson',
    'district': None,
    'registered': False,
    'description': 'Å å Ø ø Æ æ 葉繼問 イップ・マン 엽문'
    }
    return smith_item

def get_johnson_family_item():
    johnson_item = {
    'id': 'Smith_' + str(uuid.uuid4()),
    'lastName': 'Smith',
    'parents': None,
    'children': None,
    'address': {
        'state': 'WA',
        'city': 'Redmond'
    },
    'registered': True,
    'description': 'Å å Ø ø Æ æ 葉繼問 イップ・マン 엽문'
    }
    return johnson_item
