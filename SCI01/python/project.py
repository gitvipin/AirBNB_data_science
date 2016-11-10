#!/usr/bin/env python

import pdb

class User(object):
    def __init__(self):
        self.user_id = None
        self.searches = 0
        self.bookings = 0
        self.messages = 0
        self.visits = 0


class DataSc(object):

    def __init__(self):
        self.data = None
        self.users = {}
        self.cols = {}

    def read_data(self):
        # read data
        with open('airbnb.txt') as f:
            self.data = f.readlines()

        col_names = self.data[0]
        col_names = col_names.split('|')

        # extract column names
        i = 0
        for x in col_names:
            self.cols[x] = i
            i = i + 1

        # Extract data
        self.data = self.data[1:]
        self.data = [x.split('|') for x in self.data]

    def users_info(self):
        for x in self.data:
            index = self.cols['id_visitor']
            user = self.users.get(x[0])

            if not user:
                user = User()
                self.users[x[0]] = user
                user.user_id = x[0]

            index = self.cols['sent_message']
            user.messages += int(x[index])

            index = self.cols['sent_booking_request']
            user.bookings += int(x[index])

            index = self.cols['did_search']
            user.searches += int(x[index])

            index = self.cols['dim_session_number']
            user.visits = max(int(x[index]), user.visits)

    def write_user_info(self):
        with open('../data/users.txt', 'w+') as f:
            f.write('id_visitor|searches|messages|bookings|visits')
            for key, value in self.users.items():
                info = '\n%s|%s|%s|%s|%s' % (key, value.searches, value.messages,
                                        value.bookings, value.visits)
                f.write(info)



if __name__ == '__main__':
    obj = DataSc()

    # read the data
    obj.read_data()



