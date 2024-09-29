from time import sleep

def main():
    sleep(10)
    raise Exception("Application Crashing")

if __name__ == "__main__":
    print("Starting the simple test application")
    main()
