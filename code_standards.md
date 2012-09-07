Code Standards
==============

indentations camelcase? header info? methods comments? naming conventions, spacing between methods, open and close parens and braces
- Camel case variables
- Variables should be as descriptive as they need to be
- There should be one blank line between methods
- There should be no spaces after an opening paren and no spaces before a closing paren
- There should be a space after an opening { and a space before a }
- {'s should start on the same line that the block they describe starts on.
* ex: it { should respond_to(:first_name) }
- Code that extends past a reasonable amout of space should get split up into multiple lines
* ex: 
    before { @user = User.new(first_name: "Test",
							  last_name: "User",
							  email: "test@test.com",
							  password: "password",
							  password_confirmation: "password")  }