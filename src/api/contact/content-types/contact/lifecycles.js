module.exports = {
    async beforeCreate(event) {
        // console.log('beforeSave ', event)
        // event.params.data.mobile = 'xyzaaaaaaa'
        event.params.data.mobile = btoa(event.params.data.mobile)
        event.params.data.cardId = btoa(event.params.data.cardId)
    },
    async afterFindOne(event) {
        console.log('afterFineOne ', event?.result?.mobile)
        if (event?.result?.mobile) {
            try {
                event.result.mobile = atob(event?.result?.mobile);
            } catch (error) {
                console.error('Error decoding mobile:', error);
            }
        }
        if (event?.result?.cardId) {
            try {
                event.result.cardId = atob(event?.result?.cardId);
            } catch (error) {
                console.error('Error decoding mobile:', error);
            }
        }
    },
    async afterFindMany(event) {
        console.log('afterFindMany', event.result.length);
        await event.result.map(item => {
            console.log('item ', item)
            item.mobile = atob(item.mobile)
            item.cardId = atob(item.cardId)
            return item
        })
    
    },
    async beforeFindOne(event) {
        if (event.params.where.mobile) {
            event.params.where.mobile = btoa(event.params.where.mobile);
          }
          if (event.params.where.cardId) {
            event.params.where.cardId = btoa(event.params.where.cardId);
        }
  },
}