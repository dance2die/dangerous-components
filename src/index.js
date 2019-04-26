import React from 'react'

const Dangerous = (html = '', as: Component = 'div') => (
	<Component dangerouslySetInnerHTML={{ __html: html }} />
)

export default Dangerous
