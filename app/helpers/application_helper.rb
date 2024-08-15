module ApplicationHelper
    def btn_class
      'inline-block rounded bg-indigo-600 px-4 py-2 text-sm font-medium text-white hover:bg-indigo-700 focus:outline-none focus:ring active:bg-indigo-500'
    end

    def btn_back
      'inline-block rounded bg-gray-600 px-5 py-3 text-sm font-medium text-white hover:bg-gray-700 focus:outline-none focus:ring active:bg-gray-500'
    end  

    def btn_green
    'inline-block rounded bg-green-600 px-4 py-2 text-sm font-medium text-white hover:bg-green-700 focus:outline-none focus:ring active:bg-green-500'
    end

    def btn_red
      'inline-flex items-center px-4 py-2 border border-transparent text-sm font-medium rounded-md shadow-sm text-white bg-red-600 hover:bg-red-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-red-500'
    end

    def input_field
      'mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500 sm:text-sm'
    end
  
    def format_date(date)
      date.strftime('%F')
    end
  end
